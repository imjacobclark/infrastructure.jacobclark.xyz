#! /bin/bash

sed -e "s/{{API_KEY}}/$DIGITALOCEAN_API_TOKEN/g" base.json | packer build -machine-readable -