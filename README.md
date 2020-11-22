# skeleton-fastapi-gcp

Skeleton repo for developing a FastAPI app for running on GCP (CloudRun) #fastapi #cloudrun #gcp

## Requirements

- VS Code
- Python
- Pipenv
- Make (for Windows)
- Docker

## Setup Dev Environment

The best thing to use for setting this up is Chocolately.

```ps
choco install vscode
choco install make
choco install docker-desktop
choco install python3 --version=3.8.6

# pip should be installed with python automatically
pip install --user pipenv

# Use pipenv to setup local env
make install-dev
```
