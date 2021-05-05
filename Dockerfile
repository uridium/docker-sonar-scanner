FROM debian:stable-slim

ARG UID="1000"
ARG GID="1000"
ARG SONAR_SCANNER_VERSION="4.6.1.2450"
ARG NODEJS_VERSION="12"

ENV DEBIAN_FRONTEND="noninteractive" \
    USERNAME="sonar-scanner" \
    SONAR_SCANNER_HOME="/opt/sonar-scanner" \
    BASEDIR="/usr/src"

ENV SONAR_USER_HOME="${BASEDIR}/.sonar" \
    PATH="${SONAR_SCANNER_HOME}/bin:${PATH}"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        wget \
        unzip \
        pylint3 \
        xz-utils

RUN wget -qO- https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash - \
    && apt-get install -y --no-install-recommends \
        nodejs \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* \
    && npm install -g typescript@3.7.5

WORKDIR /opt

RUN wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip \
    && unzip -q sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip \
    && mv sonar-scanner-${SONAR_SCANNER_VERSION}-linux ${SONAR_SCANNER_HOME} \
    && rm *.zip

RUN groupadd --gid ${GID} ${USERNAME} \
    && useradd --uid ${UID} --gid ${GID} -ms /bin/bash ${USERNAME}

WORKDIR ${BASEDIR}
USER ${USERNAME}
ENTRYPOINT ["sonar-scanner"]
CMD ["--help"]
