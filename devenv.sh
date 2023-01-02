#!/usr/bin/env bash

nix-shell --command zsh \
          -p ruby_3_0 \
          rubyPackages_3_0.solargraph bundler \
          mailcatcher nodejs chromedriver
