# enzyme-dev-docker
[![Publish Docker images](https://github.com/tgymnich/enzyme-dev-docker/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/tgymnich/enzyme-dev-docker/actions/workflows/docker-publish.yml)

Dockerfiles for setting up an environment for building and testing Enzyme.

# VSCode development container

Create a `devcontainer.json` in your project:
```
// available images ubuntu versions: [20, 18]
// available llvm versions: [7, 8, 9, 10, 11, 12]
{
    "name": "Enzyme",
    "image": "ghcr.io/tgymnich/enzyme-dev-docker/ubuntu-20-llvm-11:latest",
    // don't mount local directory (better performance)
    // "workspaceMount": "source=enzyme-source,target=/workspace,type=volume",
    // "workspaceFolder": "/workspace",
    "mounts": [
        "source=enzyme-bashhistory,target=/commandhistory,type=volume",
        "source=enzyme-extensions,target=/root/.vscode-server/extensions,type=volume",
        "source=enzyme-extensions-insiders,target=/root/.vscode-server-insiders/extensions,type=volume",
    ]
}
```
