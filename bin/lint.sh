#!/bin/bash

SCRIPT_NAME="lint.sh"

HELP=false
FIX=false
FIX_SAFE=false
JS=false
RUBY=false

# Parse command line args
POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        --fix)
            FIX=true
            shift # past argument
            ;;
        --fix-safe)
            FIX_SAFE=true
            shift # past argument
            ;;
        --js)
            JS=true
            shift # past argument
            ;;
        --ruby)
            RUBY=true
            shift # past argument
            ;;
        -h|--help)
            # Clobber everything
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
    echo "$SCRIPT_NAME initializes the imagine-grinnell rails application"
    echo "$SCRIPT_NAME [no parameters]"
    echo "  -h or --help         Print this message"
    echo "  --fix                Attempt to fix some of the errors found"
    echo "  --fix-safe           Run fixes considered safe"
    echo "  --js                 Only run javascript linting (eslint)"
    echo "  --ruby               Only run ruby linting (rubocop)"
    echo ""
    echo "Defaults to running both javascript and ruby linters."
    echo "Note that --fix can be passed with --js or --ruby to only"
    echo "attempt to fix ruby or javascript, respectively."
    exit 0
fi

RUN_RUBY=true
RUN_JS=true

## Flag logic
if $RUBY && $JS ; then
    true # pass
elif $RUBY ; then
    RUN_JS=false
elif $JS ; then
    RUN_RUBY=false
fi

# We want to be safe by default
if $FIX && $FIX_SAFE ; then
    FIX=false
fi

EXIT_STATUS="0"

## Javascript
ESLINT_COMMAND="yarn run eslint $SCRIPTPATH/../app"
if $RUN_JS ; then
    echo "Running eslint (javascript)..."
    if $FIX || $FIX_SAFE ; then
        eval $ESLINT_COMMAND --fix \
            || EXIT_STATUS="1"
    else
        eval $ESLINT_COMMAND \
            || EXIT_STATUS="1"
    fi
fi

## Ruby
function cleanup() {
    popd # Undo the pushd cd
}
pushd "$SCRIPTPATH/.." # Temporarily cd into the root of the project
trap cleanup EXIT # run cleanup when this script exits

RUBOCOP_COMMAND="rubocop"
if $RUN_RUBY ; then
    echo "Running rubocop (ruby)..."
    if $FIX ; then
        eval $RUBOCOP_COMMAND -a \
             || EXIT_STATUS="1"
    elif $FIX_SAFE ; then
        eval $RUBOCOP_COMMAND -x \
             || EXIT_STATUS="1"
    else
        eval $RUBOCOP_COMMAND \
             || EXIT_STATUS="1"
    fi
fi

# Propagate any failures to this script's return value
exit $EXIT_STATUS
