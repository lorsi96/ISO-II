docker run \
    -it --rm \
    --privileged \
    -v $(pwd):/workspace \
    -v /dev:/dev \
    --network host \
    lorsi/crosstool /bin/bash