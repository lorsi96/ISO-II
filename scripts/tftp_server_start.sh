#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
docker run \
    --network host \
    -p 0.0.0.0:69:69/udp \
    -it --rm \
    -v $SCRIPT_DIR/../tftp-server:/var/tftpboot \
    pghalliday/tftp