#!/bin/sh

set -eu

# As defined in the client SDK
DEFAULT_EMULATOR_PROJECT="google-cloud-firestore-emulator"

FIRESTORE_PROJECT="${FIRESTORE_PROJECT:-"$DEFAULT_EMULATOR_PROJECT"}"

set -x
exec firebase emulators:start --only firestore --project "$FIRESTORE_PROJECT"
