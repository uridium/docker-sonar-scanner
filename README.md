Docker SonarScanner
--

SonarScanner container to use when there is no specific scanner for your build system.

[SonarScanner](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/)

### Installation

    docker pull uridium/sonar-scanner

to download the latest version, or:

    docker pull uridium/sonar-scanner:4.3.0.2102

to download a specific sonar-scanner version

### Use

    docker run -u "$(id -u):$(id -g)" -v "$(pwd):/usr/src" uridium/sonar-scanner -Dsonar.host.url=${SONAR_HOST_URL} -Dsonar.login=${SONAR_AUTH_TOKEN} -Dsonar.projectKey=${SONAR_PROJECT_KEY} -Dsonar.projectName=${SONAR_PROJECT_NAME}

to run analysis in the current directory.

You can pass any [analysis parameter](https://docs.sonarqube.org/latest/analysis/analysis-parameters/) to the container using `-D`
