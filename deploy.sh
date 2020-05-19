#!/usr/bin/env bash
set -eu -o pipefail

function login() {
  local -r pem_file=$(mktemp)
  printf "$AZ_PEM" | base64 --decode > $pem_file
  echo "Logging in to Azure with username $AZ_USERNAME to tenant $AZ_TENANT"
  az login --service-principal --username $AZ_USERNAME  --tenant $AZ_TENANT --password $pem_file
}

function docker_push() {
  local -r USERNAME=$1
  # Below token login doesn't work but it should be. So workaround (not really) is to use sudo to make docker work
  #local -r TOKEN="$(az acr login --name "${USERNAME}" --expose-token | jq -r '.accessToken')"
  #echo -e "Token is \n${TOKEN}\n"
  #echo "${TOKEN}" | sudo docker login -u "${AZ_USERNAME}" "${USERNAME}.azurecr.io" --password-stdin

  #sudo cp -r $HOME/.azure /root
  az acr login --name "${USERNAME}"

  # tag the image
  # publish the image

  docker push "${IMAGE_NAME}:${TAG}"
}

function main() {
  login "$@"
  echo "Going to push Docker Image into ECR"
  docker_push "mresetar"
}

main "$@"