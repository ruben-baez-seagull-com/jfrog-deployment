#!/bin/bash

set -e

USER=$1
PASSWORD=$2
ARTIFACT=$3
URL=$4
DELAY=$5

if [ -z $USER ]; then
    echo 'Required username parameter'
    exit 1
fi

if [ -z $PASSWORD ]; then
    echo 'Required password parameter'
    exit 1
fi

if [ -z $URL ]; then
    echo 'Required repository parameter'
    exit 1
fi

if [ -z $ARTIFACT ]; then
    echo 'Required repository parameter'
    exit 1
fi

function fail {
    echo $1 >&2
    break;
}

function run {
    local n=1
    local max=3
    while true; do
    "$@" && break || {
        if [[ $n -lt $max ]]; then
            ((n++))
            echo ::set-output name=output::"Upload failed. Attempt $n/$max:"
            sleep $DELAY;
        else
            fail ::set-output name=output::"The upload has failed after $n attempts."
        fi
    }
    done
}

echo "Artifact to upload: $ARTIFACT"
run curl -X PUT -u $USER:$PASSWORD -T $ARTIFACT $URL
echo ::set-output name=output::"Artifact deployed"