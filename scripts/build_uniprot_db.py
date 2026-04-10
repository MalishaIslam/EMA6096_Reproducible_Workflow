  #!/usr/bin/env python3

import os
import time
import sqlite3
import requests
import pandas as pd
from typing import Dict, List, Optional


BASE_URL = "https://rest.uniprot.org/uniprotkb/search"

# You can change these later if needed
BATCH_SIZE = 500
TARGET_X_COUNT = 100
MAX_RETRIES = 3
SLEEP_BETWEEN_RETRIES = 2

OUTPUT_DIR = "output"
DB_ALL_PATH = os.path.join(OUTPUT_DIR, "uniprot_all_sequences.db")
DB_X_PATH = os.path.join(OUTPUT_DIR, "uniprot_sequences_with_X.db")

TABLE_ALL = "all_sequences"
TABLE_X = "sequences_with_x"


def ensure_output_dir(output_dir: str) -> None:
    """Create output directory if it does not exist."""
    os.makedirs(output_dir, exist_ok=True)


def safe_get(
    url: str,
    params: Optional[Dict] = None,
    max_retries: int = 3,
    sleep_sec: int = 2
) -> requests.Response:
    """HTTP GET with retry logic."""
    for attempt in range(1, max_retries + 1):
        try:
            response = requests.get(url, params=params, timeout=60)
            response.raise_for_status()
            return response
        except requests.exceptions.RequestException as exc:
            print(f"[Request failed] Attempt {attempt}/{max_retries}: {exc}")
            if attempt < max_retries:
                time.sleep(sleep_sec)
            else:
                raise


def get_next_link(headers: Dict) -> Optional[str]:
    """
    Parse UniProt pagination link from the HTTP Link header.
    Returns the next page URL if present.
    """
    link_header = headers.get("Link")
    if not link_header:
        return None

    parts = link_header.split(",")
    for part in parts:
        if 'rel="next"' in part:
            start = part.find("<") + 1
            end = part.find(">")
            if start > 0 and end > start:
                return part[start:end]
    return None


def extract_function_text(comments: List[Dict]) -> str:
    """
    Extract FUNCTION comment text from UniProt record comments.
    """
    if not comments:
        return ""

    function_texts = []
    for comment in comments:
        if comment.get("commentType") == "FUNCTION":
            texts = comment.get("texts", [])
            for item in texts:
                value = item.get("value", "")
                if value:
                    function_texts.append(value.strip())

    return " ".join(function_texts)


def parse_record(record: Dict) -> Dict:
    """
    Parse one UniProt JSON record into required schema.
    Required columns:
      - Entry
      - sequence_name
      - sequence
      - length
      - functional_activity
    """
    entry = record.get("primaryAccession", "")
    sequence_name = record.get("uniProtkbId", "")
    sequence_obj = record.get("sequence", {}) or {}
    sequence = sequence_obj.get("value", "")
    length = sequence_obj.get("length", None)
    functional_activity = extract_function_text(record.get("comments", []))

    return {
        "Entry": entry,
        "sequence_name": sequence_name,
        "sequence": sequence,
        "length": length,
        "functional_activity": functional_activity,
    }


def sequence_has_x(sequence: str) -> bool:
    """Check if the protein sequence contains X or x."""
    if not isinstance(sequence, str):
        return False
    return "X" in sequence.upper()


def fetch_uniprot_data(
    batch_size: int = 500,
    target_x_count: int = 100
) -> tuple[pd.DataFrame, pd.DataFrame]:
    """
    Fetch UniProt data page by page.

    Returns:
        df_all: all sequences collected during scan
        df_x: only sequences containing X/x, capped at target_x_count
    """
    all_rows = []
    x_rows = []

    params = {
        "query": "reviewed:true",
        "format": "json",
        "size": batch_size,
    }

    next_url = BASE_URL
    page_num = 1
    total_seen = 0

    while True:
        print(f"[Fetch] Page {page_num}")

        response = safe_get(
            next_url,
            params=params if next_url == BASE_URL else None,
            max_retries=MAX_RETRIES,
            sleep_sec=SLEEP_BETWEEN_RETRIES
        )

        payload = response.json()
        results = payload.get("results", [])

        if not results:
            print("[Fetch] No more results returned.")
            break

        for record in results:
            parsed = parse_record(record)

            if not parsed["sequence"]:
                continue

            all_rows.append(parsed)
            total_seen += 1

            if sequence_has_x(parsed["sequence"]):
                if len(x_rows) < target_x_count:
                    x_rows.append(parsed)

            if len(x_rows) >= target_x_count:
                print(f"[Done] Reached target of {target_x_count} sequences containing X/x.")
                df_all = pd.DataFrame(all_rows)
                df_x = pd.DataFrame(x_rows[:target_x_count])
                print(f"[Stats] Total scanned: {total_seen}")
                print(f"[Stats] Total all-sequence rows: {len(df_all)}")
                print(f"[Stats] Total X-sequence rows: {len(df_x)}")
                return df_all, df_x

        next_page = get_next_link(response.headers)
        if not next_page:
            print("[Fetch] No next page found.")
            break

        next_url = next_page
        params = None
        page_num += 1

    df_all = pd.DataFrame(all_rows)
    df_x = pd.DataFrame(x_rows[:target_x_count])

    print(f"[Finished] Total scanned: {total_seen}")
    print(f"[Finished] Total all-sequence rows: {len(df_all)}")
    print(f"[Finished] Total X-sequence rows: {len(df_x)}")

    return df_all, df_x


def save_dataframe_to_sqlite(
    df: pd.DataFrame,
    db_path: str,
    table_name: str
) -> None:
    """Save DataFrame to SQLite database."""
    conn = sqlite3.connect(db_path)
    try:
        df.to_sql(table_name, conn, if_exists="replace", index=False)
        conn.commit()
        print(f"[Saved] {len(df)} rows -> {db_path} (table: {table_name})")
    finally:
        conn.close()


def main() -> None:
    ensure_output_dir(OUTPUT_DIR)

    print("[Start] Downloading UniProt records...")
    df_all, df_x = fetch_uniprot_data(
        batch_size=BATCH_SIZE,
        target_x_count=TARGET_X_COUNT
    )

    print("[Save] Writing SQLite databases...")
    save_dataframe_to_sqlite(df_all, DB_ALL_PATH, TABLE_ALL)
    save_dataframe_to_sqlite(df_x, DB_X_PATH, TABLE_X)

    print("[Complete] Database creation finished.")
    print(f"[Output] All sequences DB: {DB_ALL_PATH}")
    print(f"[Output] X-only sequences DB: {DB_X_PATH}")


if __name__ == "__main__":
    main()
