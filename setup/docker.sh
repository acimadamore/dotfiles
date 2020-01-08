#!/bin/bash

docker__configure() {
  sudo groupadd docker
  sudo usermod -aG docker $USER
}
