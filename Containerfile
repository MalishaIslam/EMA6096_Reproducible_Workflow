FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    make \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Typst and make sure it is available as "typst"
RUN curl -fsSL https://typst.community/typst-install/install.sh | sh \
    && find /root -type f -name typst -exec ln -sf {} /usr/local/bin/typst \; \
    && typst --version

COPY . /app

RUN pip install --no-cache-dir \
    pandas \
    requests \
    numpy \
    scipy \
    matplotlib \
    seaborn \
    scikit-learn \
    umap-learn
