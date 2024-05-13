#!/bin/bash

packer build -machine-readable \
  -var "golden_ami_name=golden-ami" \
  -var "image_name=nginx" \
  -var "image_version=0.3" \
  -var "filePath=./index2.html" .
