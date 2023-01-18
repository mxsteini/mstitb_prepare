#!/usr/bin/env bash
set -o errexit

usage() {
  echo "$0 usage:" && grep " .)\ #" $0
  exit 0
}

function checkTools() {
  checkTool 'ssh-keygen'
  SSH_KEYGEN=$(which -v ssh-keygen)

  checkTool 'htpasswd'
  HTPASSWD=$(which htpasswd)

  checkTool 'cat'
  CAT=$(which cat)

  checkTool 'hexdump'
  HEXDUMP=$(which hexdump)

  checkTool 'curl'
  CURL=$(which curl)
}

function checkTool() {
  if ! command -v $1 &>/dev/null; then
    echo "$1 could not be found"
    exit_abnormal
  fi
  echo $1 found
}

function insertVariables() {
  for key in "${!PREPARE[@]}"; do
    sed -i -e 's#PREPARE_'${key}'#'${PREPARE[${key}]}'#g' $1
  done
}

function createStructure() {
  echo ${PREPARE[PORJECT_PATH]}
  cd ${PREPARE[PORJECT_PATH]}
  mkdir -p stage
  pushd stage
  mkdir -p {releases,shared}
  mkdir -p releases/{release-1,release-2,release-3}
  mkdir -p shared/{configuration,public,var}
  mkdir -p shared/public/{fileadmin,uploads}
  pushd releases
  ln -s release-3 next
  ln -s release-2 current
  ln -s release-1 previous
  popd
  curl https://raw.githubusercontent.com/mxsteini/mstitb_prepare/main/live/LocalConfiguration.php --output shared/configuration/LocalConfiguration.php
  popd
  cp -ra stage production

  curl https://raw.githubusercontent.com/mxsteini/mstitb_prepare/main/live/dotEnv.sh --output production/releases/current/.env
  insertVariables production/releases/current/.env
  cp -f production/releases/current/.env production/releases/next/.env

  curl https://raw.githubusercontent.com/mxsteini/mstitb_prepare/main/stage/dotEnv.sh --output stage/releases/current/.env
  insertVariables stage/releases/current/.env
  cp -f stage/releases/current/.env stage/releases/next/.env
}

function createHtaccess() {
  ${CAT} >.htaccess <<EOF
<If "(%{HTTP_HOST} != '${URL}') && (%{HTTP_HOST} != 'www.${URL}')">
 AuthUserFile ${PREPARE[PORJECT_PATH]}/.htpasswd
 AuthName EnterPassword
 AuthType Basic
 Require valid-user
</If>

SetEnv TYPO3_CONTEXT "Production"

<If "%{HTTP_HOST} == 'stage.${URL}'">
  SetEnv TYPO3_CONTEXT "Production/Stage"
</If>

<If "%{HTTP_HOST} == 'next.${URL}'">
  SetEnv TYPO3_CONTEXT "Production/Next"
</If>
EOF
}

function createHtPassword() {
  ${HTPASSWD} -b -c ${PREPARE[PORJECT_PATH]}/.htpasswd ${PREPARE[HT_USER]} ${PREPARE[HT_PASS]}
}

function createCiKey() {
  ${SSH_KEYGEN} -f ~/.ssh/id_rsa_gitlab
  cat ~/.ssh/id_rsa_gitlab.pub >> ~/.ssh/authorized_keys
  cat ~/.ssh/id_rsa_gitlab
}

function exit_abnormal() { # Function: Exit with error.
  echo exit_abnormal
  usage
  exit 1
}

checkTools

declare -A PREPARE

source ./config.sh

createStructure
createHtaccess
createHtPassword