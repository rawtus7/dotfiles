#!/usr/bin/env bash

set -eu

echo ">>>>> main.sh >>>>>"

# if ! command -v xcodebuild 1>/dev/null; then
if [ ! -e "/Applications/Xcode.app" ]; then
  echo 'Xcode is not installed.'
  echo 'mas requires Xcode. Please install the latest version of Xcode from App Store.'
  echo 'For more info, see https://github.com/mas-cli/mas.'
  exit 1
fi

if [ "$(xcode-select -p 1>/dev/null; echo $?)" != 0 ]; then
  echo 'Command line tool is not installed.'
  echo 'Invoked installation.'
  echo 'Please follow prompt window.'
  xcode-select --install
  exit 1
fi

./scripts/configure.sh
echo

./scripts/deploy.sh
echo

./scripts/homebrew.sh
echo

# prioritize ARM Homebrew
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
brew bundle --no-lock
echo

mackup restore
echo

# ./scripts/initialize.sh
# echo

echo "<<<<< main.sh <<<<<"
echo "Bootstrapping DONE!"
