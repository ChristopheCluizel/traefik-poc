#!/usr/bin/env bash

set -e

function print_usage() {
    echo "Deploy.

Usage: $0 [arguments]
    -h, --help                                  Display this help message
    --server-ip            <SERVER_IP>          The IP of the server we want to deploy on
"
}

# check that we run this script from project root directory
CURRENT_DIRECTORY=$( basename "$PWD" )

if [ "$CURRENT_DIRECTORY" != "traefik-poc" ]; then
    echo "You must run this script from the project root directory."
    exit 1
fi

# Retrieve project path
DIR="$( pwd )"

# Load helpers
# shellcheck source=scripts/functions.sh
source "${DIR}/scripts/functions.sh"

# get input arguments
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --server-ip)
        SERVER_IP="$2"
        shift # past argument
        shift # past value
        ;;
        -h|--help)
        print_usage
        exit 0
        ;;
        *)
        unknown_argument "$@"
        ;;
    esac
done

# Validate mandatory arguments
check_argument "server-ip" "$SERVER_IP"

echo "==== Deploy"
cd ..
rsync -avz --exclude "venv3" --exclude ".idea" --exclude ".git" traefik-poc ec2-user@"$SERVER_IP":~