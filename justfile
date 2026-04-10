# Justfile -- User-facing build commands
# Usage:
#   just              # build everything
#   just build-db     # build UniProt databases
#   just pdf          # build report PDF
#   just clean        # remove generated outputs
#   just build-image  # build container image
#   just local        # run locally without container

compose := "podman compose" # or "docker compose"

# Default target builds everything
default: all


# Build everything
all:
    {{compose}} run --rm builder make all


# Build UniProt databases
build-db:
    {{compose}} run --rm builder make run

# Clean outputs
clean:
    rm -rf output build


# Build container image only
build-image:
    {{compose}} build


# Run locally (no container)
local target="all":
    make {{target}}
