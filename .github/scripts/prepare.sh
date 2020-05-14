#!/bin/sh

PRIVATE_KEY="${1}"

#

mkdir -p "${HOME}/.ssh"
echo "${PRIVATE_KEY}" > "${HOME}/.ssh/lustapo_rsa"
chmod 400 "${HOME}/.ssh/lustapo_rsa"

cat <<EOT > "${HOME}/.ssh/config"
Host upstream
  Hostname github.com
  IdentityFile ~/.ssh/lustapo_rsa
EOT
chmod 644 "${HOME}/.ssh/config"
