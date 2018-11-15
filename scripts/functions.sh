#!/usr/bin/env bash

function check_argument() {
    if [ -z "$2" ]; then
        echo "Argument [$1] is missing, please provide all arguments as following:"
        print_usage
        exit 1
    fi
}