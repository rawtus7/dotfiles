#!/usr/bin/env bash

echo ">>>>> homebrew.sh >>>>>"

command_prefix=""

# when ARM
if [ "$(uname -m)" = "arm64" ]; then
  # Install Homebrew for ARM
  if ! command -v /opt/homebrew/bin/brew > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  # Install Rosetta 2
  softwareupdate --install-rosetta --agree-to-license
  # Install on Rosetta 2
  command_prefix="arch -arch x86_64"
fi

# Install Homebrew for Intel
if ! command -v /usr/local/bin/brew >/dev/null 2>&1; then
  # Install Homebrew: https://brew.sh/
  $command_prefix /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "<<<<< homebrew.sh <<<<<"
