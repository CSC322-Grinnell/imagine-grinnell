#!/bin/bash

BYPASS=false
HELP=false

SCRIPT_NAME="nuke-docker.sh"

# Parse command line args
POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -h|--help)
            # Clobber everything
            HELP=true
            shift # past argument
            ;;
        -y|--yes)
            BYPASS=true
            shift
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

if $HELP ; then
    echo "$SCRIPT_NAME removes ALL docker information on disk."
    echo "After running this command, you will lose ALL your database"
    echo "information, ALL images, and have to re-download and build EVERYTHING."
    echo "You should really only run this script when your computer is out of"
    echo "disk space, or if you've spent two hours trying to solve an"
    echo "un-reproduceable bug with docker on your machine."
    echo
    echo "Usage:"
    echo "$SCRIPT_NAME [no parameters]"
    echo "  -y or --yes          Ignore the warning"
    echo "  -h or --help         Print this message"
    exit 0
fi


if ! $BYPASS ; then
    echo "WARNING: This will remove ALL docker data, short of the docker/docker-compose"
    echo "commands themselves. After running this command, you will lose ALL your database"
    echo "information, ALL images, and have to re-download and build EVERYTHING."
    echo
    echo "You should really only run this script when your computer is out of disk space."
    read -p "Are you sure that you want to continue? [y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
    fi
fi

exit 0

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
    docker volume rm "$volume"
done

echo
echo "Nuking everything else (docker system prune -a)..."
echo
docker system prune -a
