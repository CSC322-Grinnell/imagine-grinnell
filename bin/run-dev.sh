#!/bin/bash

# Unofficial Strict mode
set -euo pipefail
#IFS=$'\n\t'

rm -f tmp/pids/server.pid

ESCAPE_CHAR=$(printf '\033')
RED_ESCAPE="${ESCAPE_CHAR}[91m"
CYAN_ESCAPE="${ESCAPE_CHAR}[96m"
COLOR_RESET_ESCAPE="${ESCAPE_CHAR}[39m"

RAILS_COMMAND="bundle exec rails server -p 3000 -b '0.0.0.0'"
WEBPACK_COMMAND='./bin/webpack-dev-server'
parallel --jobs 2 --lb "eval {}" ::: "$RAILS_COMMAND 2>&1 | sed -u 's/^/${RED_ESCAPE}rails   |$COLOR_RESET_ESCAPE /'" "$WEBPACK_COMMAND | sed -u 's/^/${CYAN_ESCAPE}webpack |$COLOR_RESET_ESCAPE /'"
