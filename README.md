# Docker image to run the Firestore emulator

This runs the Firestore emulator.

## How to use?

### Connecting to the emulator

To connect to the emulator using the Firebase SDK, export the environment variable:

```sh
export FIRESTORE_EMULATOR_HOST="localhost:8080"
```

This is the address of the Firestore emulator and the SDK should automatically pick this up.

Additionally, you can configure the following environment variables:

* `FIRESTORE_PROJECT`: the project used by the client SDK.

  Configure your client SDK with the same as this variable to visualize the
  content of the database from the emulator UI.

  The Firestore emulator supports multiple projects in the same instance: if the
  emulator and the client don't use the same project value, the client will
  still run correctly, but you won't be able to see the content of the database
  in the UI.

  Default value: `google-cloud-firestore-emulator` (same value as in the client SDK)


### Starting the emulator

Start a container from this image exposing the following ports:

* TCP/4000: the Firebase UI
* TCP/8080: the Firestore database

You can use:

```sh
docker run --rm -ti -p 4000:4000 -p 8080:8080 ghcr.io/multani/firestore-emulator:latest
```

Or via Docker Compose:

```yaml
version: "3.7"
services:
  firebase:
    image: ghcr.io/multani/firestore-emulator:latest
    ports:
      - 4000:4000 # UI
      - 8080:8080 # Firestore
```

You can open the UI via http://127.0.0.1:4000


#### GitHub Actions

In GitHub Actions, you can configure something like:

```yaml
name: Test

on:
  push:
    pull_requests:
      - "**"

jobs:
  test:
    runs-on: ubuntu-latest

    services:
      firestore:
        image: ghcr.io/multani/firestore-emulator:latest
        ports:
          - 8080:8080 # firestore

    env:
      # Connect locally to the Firestore Docker container
      # This variable should be automatically picked up by Firestore client SDK.
      FIRESTORE_EMULATOR_HOST: localhost:8080

    steps:
      - name: Checkout
        uses: actions/checkout@v3

      # ...
```
