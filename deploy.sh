#!/usr/bin/env bash
set -euo pipefail
docker compose pull || true
docker compose up -d --build --remove-orphans
docker compose ps
