#!/usr/bin/env bash
set -eu -o pipefail

function main() {
  local username=$1
  local tenant=$2
  local pem=$3
  docker run -it -e "AZ_USERNAME=$username" -e "AZ_TENANT=$tenant" -e "AZ_PEM=$pem" --name circle-ci-azure --rm \
    -v /c/projects/circleci-demo-java-spring/:/app -v /var/run/docker.sock:/var/run/docker.sock \
    --entrypoint /app/deploy.sh openjdk11-gradle551-az251:v2
}

main "$@"
