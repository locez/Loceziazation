#!/usr/bin/env bash
set -euo pipefail

# for python
pip install -U black --user
sudo npm i -g pyright

# for java
sudo emerge -au dev-java/maven-bin

# rust
rustup component add rustfmt-preview
cargo install cargo-check
rustup component add clippy-preview
rustup component add rust-src

#
#
function update_rust_analyzer() {
	curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
	chmod +x ~/.local/bin/rust-analyzer
}

# for sh
GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt
