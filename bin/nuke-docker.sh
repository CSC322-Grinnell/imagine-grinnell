#!/bin/bash

NO_CLOBBER=false
FORCE_CLOBBER=false

# Parse command line args
POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -n|--no-clobber)
            NO_CLOBBER=true
            shift # past argument
            ;;
        -f|--force)
            # Clobber everything
            FORCE_CLOBBER=true
            shift # past argument
            shift # past value
            ;;
        *)    # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
            ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

# Unofficial Strict mode
set -euo pipefail
IFS=$'\n\t'

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

echo
echo "Nuking containers..."
echo

ALL_CONTAINERS="$(docker ps -a -q --format '{{.ID}}')"

for container in $ALL_CONTAINERS ; do
    docker rm "$container"
done

echo
echo "Nuking images..."
echo

ALL_VOLUMES="$(docker image ls -q)"

for volume in $ALL_VOLUMES ; do
    docker rm -v "$volume"
done

echo
echo "Nuking everything else (docker system prune -a)..."
echo
docker system prune -a
