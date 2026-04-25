FROM python:3.11-slim

WORKDIR /app

# RUN apt-get update && apt-get install -y --no-install-recommends \
#    make \
#    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    make \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://typst.community/typst-install/install.sh | sh
ENV PATH="/root/.typst/bin:${PATH}"

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
