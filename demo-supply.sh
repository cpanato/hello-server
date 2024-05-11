#!/usr/bin/env bash

########################
# include the magic
########################
. /Users/cpanato/code/src/github.com/paxtonhare/demo-magic/demo-magic.sh

TYPE_SPEED=70
# hide the evidence

clear


pei "cosign verify --certificate-oidc-issuer=https://token.actions.githubusercontent.com --certificate-identity=https://github.com/chainguard-images/images/.github/workflows/release.yaml@refs/heads/main cgr.dev/chainguard/nginx@sha256:3a1a5bc190465da5e2eca9edcb45270ed63c5cea6ae6b4ecd4594338b9233216 | jq -r .[0] >> sig.json"

wait
clear

pei "cosign verify-attestation --type spdx --certificate-oidc-issuer=https://token.actions.githubusercontent.com --certificate-identity=https://github.com/chainguard-images/images/.github/workflows/release.yaml@refs/heads/main cgr.dev/chainguard/nginx@sha256:3a1a5bc190465da5e2eca9edcb45270ed63c5cea6ae6b4ecd4594338b9233216 | jq -r .payload | base64 -d | jq -r . >> spdx-att.json"

wait
clear
pei "cosign verify-attestation  --type https://slsa.dev/provenance/v1 --certificate-oidc-issuer=https://token.actions.githubusercontent.com --certificate-identity=https://github.com/chainguard-images/images/.github/workflows/release.yaml@refs/heads/main cgr.dev/chainguard/nginx@sha256:3a1a5bc190465da5e2eca9edcb45270ed63c5cea6ae6b4ecd4594338b9233216 | jq -r .payload | base64 -d | jq -r . >> prov-att.json"