
# Cross Tool Dockerized Environment
## Description
The cross tool dockerized environment mounts the current working directory
inside a Docker container, which lets the user run any `ct-ng` command from the
terminal while still using their host working directory.

## Instructions
- Install Docker.
- Build the Docker image: `./scripts/docker_build.sh`.
- Open a terminal inside the dockerized environment `./scripts/docker_run.h`
- Inside the newly opened terminal, run `ct-ng --help` to ensure the tool was
properly installed.

