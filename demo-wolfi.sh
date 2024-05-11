#!/usr/bin/env bash

########################
# include the magic
########################
. /Users/cpanato/code/src/github.com/paxtonhare/demo-magic/demo-magic.sh

TYPE_SPEED=60
# hide the evidence
clear


pei "docker pull cgr.dev/chainguard/melange:latest"
pei "docker pull cgr.dev/chainguard/apko:latest"

wait
clear

pei "docker run --rm -v "${PWD}":/work cgr.dev/chainguard/melange keygen"

wait
clear

pei "docker run --privileged --rm -v \"${PWD}\":/work -- \
  cgr.dev/chainguard/melange build melange.yaml \
  --arch $(uname -m) \
  --signing-key melange.rsa --keyring-append melange.rsa.pub"

wait
clear

pei "docker run --rm -v ${PWD}:/work cgr.dev/chainguard/apko build --workdir=/work --log-level=debug -k melange.rsa.pub apko.yaml hello-wolfi:latest hello-wolfi.tar"

wait
clear

docker load < hello-wolfi.tar


pei "docker run --name wolfi-demo --rm -p 8080:8080 -d hello-wolfi:latest-arm64"

wait
clear

pei "curl http://localhost:8080"

docker stop wolfi-demo