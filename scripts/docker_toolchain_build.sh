export GID=$(id -g)
docker run \
    --user $UID:$GID \
    --rm \
    -v $(pwd):/workspace \
    lorsi/crosstool ct-ng build && ct-ng clean
