FROM docker:stable

LABEL "name"="Artifactory Action"
LABEL "maintainer"="Ruben Baez <ruben.baez@mojix.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="Artifactory Action"
LABEL "com.github.actions.description"="GitHub Actions for build and publish jfrog artifact with timout"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="red"

RUN apk update \
    && apk upgrade \
    && apk add --no-cache curl

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]