#!/usr/bin/env bash
set -eu -o pipefail

function main() {
  local username=$1
  local tenant=$2
  local pem=$3
  # Setup Windows
  # export WIN_LOCAL_DIR=/c/projects/circleci-demo-java-spring/
  local current_dir=${WIN_LOCAL_DIR:-$(pwd)}
  local localdir=${CIRCLE_WORKING_DIRECTORY:-$current_dir}
  docker run -it -e "AZ_USERNAME=$username" -e "AZ_TENANT=$tenant" -e "AZ_PEM=$pem" --name circle-ci-azure --rm \
    -v "${localdir}:/app" -v /var/run/docker.sock:/var/run/docker.sock \
    --entrypoint /app/deploy.sh mresetar/openjdk11-gradle551-az251:latest
}

main "$@"
