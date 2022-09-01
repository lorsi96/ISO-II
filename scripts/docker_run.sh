export GID=$(id -g)


docker run \
    --env SCP=/dev/null \
    --env CROSS_COMPILE=aarch64-unknown-linux-gnu- \
    --user $UID:$GID \
    -it --rm \
    --privileged \
    -v $(pwd):/workspace \
    -v /dev:/dev \
    --network host \
    lorsi/crosstool:1.0.0 /bin/bash