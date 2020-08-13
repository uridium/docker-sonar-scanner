Docker SonarScanner
--
[![Docker Hub](https://img.shields.io/docker/cloud/build/uridium/sonar-scanner.svg)](https://hub.docker.com/r/uridium/sonar-scanner/builds)

[SonarScanner](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/) container to use when there is no specific scanner for your build system.

### Requirements

* docker

### Installation

To build the container:

    docker build -t uridium/sonar-scanner .

To download the latest version from the [registry](https://hub.docker.com/r/uridium/sonar-scanner/):

    docker pull uridium/sonar-scanner

To download a specific sonar-scanner version:

    docker pull uridium/sonar-scanner:4.3.0.2102

To [verify](https://github.com/GoogleContainerTools/container-structure-test) the content and structure of the container:

    docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/tests.yml:/tests.yml gcr.io/gcp-runtimes/container-structure-test test -i uridium/sonar-scanner -c tests.yml

### Use

To run analysis in the current directory:

    docker run -u "$(id -u):$(id -g)" -v "$(pwd):/usr/src" uridium/sonar-scanner -Dsonar.host.url=${SONAR_HOST_URL} -Dsonar.login=${SONAR_AUTH_TOKEN} -Dsonar.projectKey=${SONAR_PROJECT_KEY} -Dsonar.projectName=${SONAR_PROJECT_NAME}

You can pass any [analysis parameter](https://docs.sonarqube.org/latest/analysis/analysis-parameters/) to the container using `-D`
