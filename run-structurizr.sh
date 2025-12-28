#!/usr/bin/env bash

# ------------------------------------------------------------
# Run Structurizr Lite locally using Docker (WSL on Windows)
#
# Prerequisites:
# - WSL2 with Ubuntu installed
# - Docker installed and running inside WSL
# - Docker daemon accessible from this shell
#
# Usage:
#   ./run-structurizr.sh
#
# Then open:
#   http://localhost:8080
# ------------------------------------------------------------

set -e

IMAGE="structurizr/lite:latest"
PORT=8080
WORKSPACE_DIR="$(pwd)/c4"

echo "▶ Architecture Workspace:"
echo "  ${WORKSPACE_DIR}"

if [ ! -d "$WORKSPACE_DIR" ]; then
  echo "❌ ERROR: c4/ directory not found."
  echo "Make sure you run this script from the repository root."
  exit 1
fi

echo "▶ Pulling Structurizr Lite Docker image (if needed)..."
docker pull $IMAGE

echo "▶ Starting Structurizr Lite..."
echo "▶ Open http://localhost:${PORT} in your browser"
echo "▶ Press Ctrl+C to stop"

docker run --rm \
  -p ${PORT}:8080 \
  -v "${WORKSPACE_DIR}:/usr/local/structurizr" \
  $IMAGE
