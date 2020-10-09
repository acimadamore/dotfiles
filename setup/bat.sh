#!/bin/bash

bat::configure() {
  if $(! command_exists "bat"); then
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
  fi
}
