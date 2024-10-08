# enzyme-dev-docker
[![Publish Docker images](https://github.com/tgymnich/enzyme-dev-docker/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/tgymnich/enzyme-dev-docker/actions/workflows/docker-publish.yml)

Dockerfiles for setting up an environment for building and testing Enzyme.

# Docker

```
docker pull ghcr.io/enzymead/enzyme-dev-docker/ubuntu-22-llvm-16:latest
```

# VSCode Dev Container

## local development container

Create a `devcontainer.json` in your project:
```
// available ubuntu versions: [20, 22, 24]
// available llvm versions: [11, 12, 13, 14, 15, 16, 17, 18, 19]
{
    "name": "Enzyme",
    "image": "ghcr.io/enzymead/enzyme-dev-docker/ubuntu-22-llvm-16:latest",
    "mounts": [
        "source=enzyme-bashhistory,target=/commandhistory,type=volume",
        "source=enzyme-extensions,target=/root/.vscode-server/extensions,type=volume",
        "source=enzyme-extensions-insiders,target=/root/.vscode-server-insiders/extensions,type=volume",
        "source=enzyme-build,target=${containerWorkspaceFolder}/enzyme/build,type=volume",
    ],
    "postCreateCommand": "sudo chown vscode ./enzyme/build"
}
```

## remote development container

```
// available ubuntu versions: [20, 22, 24]
// available llvm versions: [11, 12, 13, 14, 15, 16, 17, 18, 19]
{
    "name": "Enzyme",
    "image": "ghcr.io/enzymead/enzyme-dev-docker/ubuntu-22-llvm-16:latest",
    "workspaceFolder": "/workspace",
    "workspaceMount": "source=enzyme-source,target=/workspace,type=volume",
    "mounts": [
        "source=enzyme-bashhistory,target=/commandhistory,type=volume",
        "source=enzyme-extensions,target=/root/.vscode-server/extensions,type=volume",
        "source=enzyme-extensions-insiders,target=/root/.vscode-server-insiders/extensions,type=volume",
    ],
    "postCreateCommand": "sudo chown vscode ./enzyme/build"
}
```

set the docker host in `settings.json`:
```
"docker.host":"ssh://your-remote-user@your-remote-machine-fqdn-or-ip-here"
```
