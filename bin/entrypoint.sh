#!/bin/bash
# Unofficial Strict mode
set -euo pipefail
IFS=$'\n\t'

rm -f /myapp/tmp/pids/server.pid || true

exec "$@"
