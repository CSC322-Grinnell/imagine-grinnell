#!/bin/bash

# Unofficial Strict mode
set -euo pipefail
IFS=$'\n\t'

rake test
