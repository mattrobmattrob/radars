#!/bin/bash

set -euo pipefail

function build() {
  env -i \
    PATH=/usr/bin:/bin \
    ZERO_AR_DATE=true \
  ld \
    -arch arm64 \
    -bundle \
    -platform_version ios-simulator 14.0.0 16.1 \
    -syslibroot "$(xcrun --show-sdk-path --sdk iphonesimulator)" \
    -objc_abi_version 2 \
    -framework Foundation \
    -framework CFNetwork \
    libOHHTTPStubs_objc.a \
    -all_load \
    -lc++ \
    -no_uuid \
    -lSystem \
    "$(xcode-select -p)"/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/*/lib/darwin/libclang_rt.iossim.a \
    -F. \
    "$@"
}

rm -rf /tmp/bins2
mkdir -p /tmp/bins2

build -o /tmp/bins2/first
build -o /tmp/bins2/second

if diff -Nur <(xxd /tmp/bins2/first) <(xxd /tmp/bins2/second); then
  echo "NO DIFF!! Running again more times to be sure"
else
  echo "HAS DIFF, something was non deterministic!"
  exit 1
fi
