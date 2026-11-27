#!/usr/bin/env bash
set -euo pipefail
local_image=${1:?Укажите имя локального образа}
image_platform=${2:?Укажите платформу}
cleanup() {
  docker logs smoke || true
  docker rm -f smoke >/dev/null 2>&1 || true
}
trap cleanup EXIT
docker run -d --name smoke --platform "$image_platform" -p 127.0.0.1:5000:5000 "$local_image"
ready=0
for attempt in {1..30}; do
  if curl --fail --silent --show-error --max-time 2 \
    http://127.0.0.1:5000/health --output health.json; then
    ready=1
    break
  fi
  sleep 1
done
if [ "$ready" -ne 1 ]; then
  echo "::error::/health did not respond after 30 attempts"
  exit 1
fi
python3 -m json.tool health.json
python3 - <<'PYTHON'
import json
from pathlib import Path
payload = json.loads(Path("health.json").read_text(encoding="utf-8"))
assert payload == {"status": "ok"}, f"unexpected /health payload: {payload}"
PYTHON
docker exec smoke id
container_uid=$(docker exec smoke id -u)
if [ "$container_uid" -eq 0 ]; then
  echo "::error::Application must not run as root"
  exit 1
fi
