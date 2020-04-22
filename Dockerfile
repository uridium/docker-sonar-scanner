FROM debian:stable-slim

ARG UID="1000"
ARG GID="1000"

ENV DEBIAN_FRONTEND="noninteractive" \
    USERNAME="sonar-scanner" \
    SONAR_SCANNER_VERSION="4.3.0.2102" \
    SONAR_SCANNER_HOME="/opt/sonar-scanner" \
    NODEJS_VERSION="v12.16.2" \
    NODEJS_HOME="/opt/nodejs" \
    BASEDIR="/usr/src"

ENV SONAR_USER_HOME="${BASEDIR}/.sonar" \
    NODE_PATH="${NODEJS_HOME}/lib/node_modules" \
    PATH="${SONAR_SCANNER_HOME}/bin:${NODEJS_HOME}/bin:${PATH}"

RUN apt-get update \
    && apt-get install -V -y --no-install-recommends \
        ca-certificates \
        git \
        wget \
        unzip \
        pylint3 \
        xz-utils \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

RUN groupadd --gid ${GID} ${USERNAME} \
    && useradd --uid ${UID} --gid ${GID} -ms /bin/bash ${USERNAME}

WORKDIR /opt

RUN wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip \
    && unzip -q sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip \
    && mv sonar-scanner-${SONAR_SCANNER_VERSION}-linux ${SONAR_SCANNER_HOME} \
    && rm *.zip \
    && wget -qO- https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-linux-x64.tar.xz | tar -xJf - \
    && mv node-${NODEJS_VERSION}-linux-x64 ${NODEJS_HOME} \
    && npm install -g typescript@3.7.5

WORKDIR ${BASEDIR}
USER ${USERNAME}
ENTRYPOINT ["sonar-scanner"]
CMD ["--help"]
