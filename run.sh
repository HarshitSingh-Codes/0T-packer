#!/bin/bash

packer build \
  -var "golden_ami_name=golden-ami" \
  -var "image_name=nginx" \
  -var "image_version=0.3" \
  -var "filePath=./index2.html" .
