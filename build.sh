#! /bin/bash

sed -e "s/{{API_KEY}}/$DIGITALOCEAN_API_TOKEN/g" packer/base/base.json | /Users/clarkja/Desktop/packer build -machine-readable -

