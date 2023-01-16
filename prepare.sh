#!/usr/bin/env bash

function createStructur() {
  mkdir -p stage
  pushd stage
  mkdir -p {releases,shared}
  mkdir -p releases/{release-1,release-2,release-3}
  mkdir -p shared/{configuration,public,var}
  mkdir -p shared/public/{fileadmin,uploads}
  touch shared/configuration/LocalConfiguration.php
  touch releases/next/.env
  pushd releases
  ln -s release-3 next
  ln -s release-2 current
  ln -s release-1 previous
  popd
  popd
  cp -ra stage production
}

function createHtaccess() {
  cat >.htaccess <<EOF
<If "(%{HTTP_HOST} != '${URL}') && (%{HTTP_HOST} != 'www.${URL}')">
 AuthUserFile ${PROJECT}/.htpasswd
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
  htpasswd -b -c ${PROJECT}/.htpasswd dev elopment
}

function createCiKey() {
  ssh-keygen -f ~/.ssh/id_rsa_gitlab
  cat ~/.ssh/id_rsa_gitlab.pub >>~/.ssh/authorized_keys
  cat ~/.ssh/id_rsa_gitlab
}

function fetchDotEnv() {
}