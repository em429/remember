#!/usr/bin/env bash

nix-shell --command zsh \
          -p ruby_3_1 \
          mailcatcher nodejs chromedriver

gem install solargraph
gem install foreman
