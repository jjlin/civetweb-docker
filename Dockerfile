#########
# Build #
#########

FROM alpine AS build

ARG CIVETWEB_VERSION
ENV CIVETWEB_CLONE_URL="https://github.com/civetweb/civetweb"

# Switch to `bash`.
RUN apk update \
 && apk add bash
SHELL ["/bin/bash", "-c"]

# Install the packages needed for the build.
ARG PKGS="build-base curl git"
RUN apk add ${PKGS}

# Clone the Civetweb repo and build.
COPY scripts/* /usr/local/bin/
WORKDIR /tmp
RUN CIVETWEB_VERSION=${CIVETWEB_VERSION} \
 && /usr/local/bin/build.sh

###########
# Package #
###########

FROM alpine

COPY --from=build /tmp/civetweb/civetweb /bin/civetweb

WORKDIR /var/www
ENTRYPOINT ["/bin/civetweb"]
