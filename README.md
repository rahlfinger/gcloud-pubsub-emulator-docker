# Google Cloud PubSub Emulator Docker

[![Docker Pulls](https://img.shields.io/docker/pulls/rahlfinger/gcloud-pubsub-emulator-docker.svg)]()
[![Docker Build Status](https://img.shields.io/docker/build/rahlfinger/gcloud-pubsub-emulator-docker.svg)]()
[![Docker Automated buil](https://img.shields.io/docker/automated/rahlfinger/gcloud-pubsub-emulator-docker.svg)]()

This is the Docker image for the [Google Cloud PubSub Emulator](https://cloud.google.com/sdk/gcloud/reference/beta/emulators/pubsub/)

## Usage

To use this image, pull from [Docker Hub](https://hub.docker.com/r/rahlfinger/gcloud-pubsub-emulator-docker/) with the following command:

    docker pull rahlfinger/gcloud-pubsub-emulator-docker:latest

or you can specify the desired version of it as follows:

    docker pull rahlfinger/gcloud-pubsub-emulator-docker:162.0.0-alpine

Then to run it you can use

    docker run --rm -p "8085:8085" rahlfinger/gcloud-pubsub-emulator-docker

If you are running it manually you will want to set up your ENV:

```
PUBSUB_EMULATOR_HOST=localhost:8085
```

Edit your /etc/hosts to add the following host:

```
127.0.0.1  pubsub.googleapis.com datastore.googleapis.com
```

On a mac you will need to setup some extra stuff to map the network between the
docker container and your local machine.  To set up a subscription push endpoint use '123.123.123.123' instead of localhost.


```
sudo ifconfig lo0 alias 123.123.123.123/24
sudo killall -HUP mDNSResponder
```

You can also use it on your `docker-compose.yml` file

```yaml
version: '2'
services:
  application:
    image: ...
    environment:
    - PUBSUB_EMULATOR_HOST="emulator:8085"
    # ...other configurations...
    depends_on:
    - emulator
  emulator:
    image: rahlfinger/gcloud-pubsub-emulator-docker
    ports:
    - "8085:8085"
```

> Notice the usage of the `PUBSUB_EMULATOR_HOST` to let the pubsub client know about the emulator.
