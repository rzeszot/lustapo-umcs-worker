#!/bin/sh

mkdir -p "${HOME}/.ssh"

echo "${DEPLOY_KEY}" > "${HOME}/.ssh/deploy_rsa"

chmod 400 "${HOME}/.ssh/deploy_rsa"

cat <<EOT > "${HOME}/.ssh/config"
Host *
  StrictHostKeyChecking no

Host upstream
  Hostname github.com
  IdentityFile ~/.ssh/deploy_rsa
EOT

chmod 644 "${HOME}/.ssh/config"
