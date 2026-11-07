#!/bin/sh

set -eu

# As defined in the client SDK
DEFAULT_EMULATOR_PROJECT="demo-google-cloud-firestore-emulator"

FIRESTORE_PROJECT="${FIRESTORE_PROJECT:-"$DEFAULT_EMULATOR_PROJECT"}"
EMULATOR_SERVICES="${EMULATOR_SERVICES:-"firestore,pubsub"}"

set -x
exec firebase emulators:start --only "$EMULATOR_SERVICES" --project "$FIRESTORE_PROJECT"
