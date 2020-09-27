FROM python:3.8-slim-buster

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3009
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https=1.8.2.1 \
        git=1:2.20.1-2+deb10u3 \
        gnupg2=2.2.12-1+deb10u1 \
        ca-certificates=20200601~deb10u1 \
        curl=7.64.0-4+deb10u1 \
        gnupg-agent=2.2.12-1+deb10u1 \
        software-properties-common=0.96.20.2-2

# hadolint ignore=DL3009
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        docker-ce=5:19.03.13~3-0~debian-buster \
        docker-ce-cli=5:19.03.13~3-0~debian-buster \
        containerd.io=1.3.7-1

RUN python3 -m pip install pre-commit

ENTRYPOINT ["pre-commit"]
