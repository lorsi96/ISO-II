export GID=$(id -g)
docker run \
    --user $UID:$GID \
    -it --rm \
    --privileged \
    -v $(pwd):/workspace \
    -v /dev:/dev \
    --network host \
    lorsi/crosstool:1.0.0 /bin/bash