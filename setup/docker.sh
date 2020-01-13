#!/bin/bash

docker::configure() {
  sudo groupadd docker
  sudo usermod -aG docker $USER
}
