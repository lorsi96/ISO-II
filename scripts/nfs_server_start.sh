#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# docker run --network=host --rm -d --name nfs --privileged \
#             -v $SCRIPT_DIR/../nfsroot:/nfsshare -e SHARED_DIRECTORY=/nfsshare \
#             itsthenetwork/nfs-server-alpine:latest
docker run                         \
  -v $SCRIPT_DIR/exports.txt:/etc/exports:ro  \
  -v /home/lorsi/Documents/MSE/ISO_II/ISO-II/nfsroot:/nfs      \
  --privileged \
  --network=host \
  erichough/nfs-server:latest