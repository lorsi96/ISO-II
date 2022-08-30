export GID=$(id -g)
docker run \
    --user $UID:$GID \
    -it --rm \
    --privileged \
    -v $(pwd):/workspace \
    -v /dev:/dev \
    --network host \
    lorsi/crosstool /bin/bash