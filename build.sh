#!/usr/bin/env bash
set -euo pipefail
IMAGE_NAME="${IMAGE_NAME:-react-devops-app}"
IMAGE_TAG="${IMAGE_TAG:-latest}"
docker build --pull -t "${IMAGE_NAME}:${IMAGE_TAG}" .
docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}" >/dev/null
echo "Built ${IMAGE_NAME}:${IMAGE_TAG}"
