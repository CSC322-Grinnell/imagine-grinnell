#!/bin/bash

SCRIPT_NAME="yarn-for-docker.sh"
HELP=false

# Parse command line args
POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -h|--help)
            HELP=true
            shift # past argument
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

if $HELP ; then
    echo "$SCRIPT_NAME automates adding npm dependencies"
    echo "This script automates the somewhat convoluted process of adding an npm"
    echo "dependency to this project. See the Docker.md file for more information"
    echo "on what this script does."
    echo
    echo "NOTE: This script SHOULD NOT be run under docker, and should instead"
    echo "be run on a host machine, in a bash shell with access to docker."
    echo "Practically, this means that this script needs to run under bash,"
    echo "either on a mac, personal linux machine, or full blown Virtual Machine"
    echo "under windows."
    echo
    echo "Usage: $SCRIPT_NAME [flags] [YARN_PASSTHROUGH]"
    echo "Flags:"
    echo "  -h or --help         Print this message"
    echo
    echo "Everything not explicitly caught by these flags is passed to yarn."
    echo "Therefore, to install a package, you can run:"
    echo "  ./$SCRIPT_NAME add MyCoolPackageIWantToInstall"
    echo "Just like \`yarn add MyCoolPackageIWantToInstall\`"
    echo "Adding a dev dependency can be done with:"
    echo "   ./$SCRIPT_NAME add --dev MyCoolPackageIWantToInstall"
    exit 0
fi

ERROR=false

if [[ -v RAILS_ON_DOCKER ]] && [[ "$RAILS_ON_DOCKER" == "YES" ]] ; then
    echo
    echo "This script cannot be run under docker. Pass the --help flag for more"
    echo "information."
    ERROR=true
fi

if ! command -v docker-compose ; then
    echo
    echo "This script must be run in a shell with access to the \`docker-compose\`"
    echo "command. Pass the --help flag for more information."
    ERROR=true
fi

# Check if any yarn-related files are dirty
GIT_STATUS="$(git status --porcelain)"
check_changed () {
    if echo "$GIT_STATUS" | grep " $1\$" &>/dev/null ; then
        echo "$1 file changed; please stash or commit your changes before"
        echo "running $SCRIPT_NAME"
        ERROR=true
    fi
}
check_changed package.json
check_changed yarn.lock

if $ERROR ; then
    exit 1
fi


cleanup() {
    popd &>/dev/null # Undo the pushd cd
}
pushd "$SCRIPTPATH/.." &>/dev/null # Temporarily cd into the root of the project
trap cleanup EXIT # run cleanup when this script exits

echo
echo "Running yarn..."
echo
# Set array separator to space temporarily
IFS=$' '
eval "docker-compose run rails yarn $*"
IFS=$'\n\t'

echo
echo "Rebuilding rails image..."
echo
docker-compose build rails

# Yoink lockfile from newly built image
echo
echo "Retrieving lockfile..."
echo

# Create a new container off of our newly built rails image
CONTAINER_ID="$(docker create imagine-grinnell_rails)"

# Cleanup docker image as well on script exit
cleanup_with_docker() {
    docker container rm $CONTAINER_ID >/dev/null || true
    cleanup
}
trap cleanup_with_docker EXIT

# Copy yarn.lock out of newly built container
# Note that docker cp is happy to clobber existing files
docker cp $CONTAINER_ID:/app/yarn.lock ./yarn.lock

echo
echo "Done! Please try \`docker-compose up\`, and commit your new changes if happy."
