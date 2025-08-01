#!/bin/bash

docker build -t svd:latest "$(dirname "$0")" $@

