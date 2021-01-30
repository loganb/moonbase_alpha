# Define global args
ARG FUNCTION_DIR="/function"
ARG RUNTIME_VERSION="2.7.2"
ARG DISTRO_VERSION="3.12"
ARG BLDTIME_PKGS=""
ARG RUNTIME_PKGS=""
ARG COMPILE_ASSETS

# Stage 1 - bundle base image + runtime
# Grab a fresh copy of the image and install GCC
FROM ruby:${RUNTIME_VERSION}-alpine${DISTRO_VERSION} AS base
# Include global args in this stage of the build
ARG FUNCTION_DIR
ARG RUNTIME_VERSION

# Install GCC (Alpine uses musl but we compile and link dependencies with GCC)
RUN apk add --no-cache \
    libstdc++

# Create function directory
RUN mkdir -p ${FUNCTION_DIR}
WORKDIR ${FUNCTION_DIR}

# Needed for the lambda runtime
RUN ln -s /tmp tmp

# Configure bundler for deployment mode
RUN bundle config --local deployment 'true' && \
    bundle config --local system_bindir ${FUNCTION_DIR}/bin && \
    bundle config --local path vendor/bundle

RUN bundle config



# Stage 2 - build function and dependencies
FROM base AS build-image
# Install aws-lambda-cpp build dependencies
RUN apk add --no-cache \
    build-base \
    libtool \
    autoconf \
    automake \
    libexecinfo-dev \
    make \
    cmake \
    libcurl

# Include global args in this stage of the build
ARG FUNCTION_DIR
ARG RUNTIME_VERSION

ARG BLDTIME_PKGS
ARG COMPILE_ASSETS

# TODO make this work
# Blank packages by default just in case there aren't any
# RUN touch system-packages.txt

# Copy list of system packages to install
# COPY system-packages.txt ${FUNCTION_DIR}/

# Install system packages
# RUN xargs apk add < system-packages.txt
# TODO make this config driven
RUN apk add ${BLDTIME_PKGS}

# Copy Gemfile spec
COPY Gemfile Gemfile.lock ${FUNCTION_DIR}/
COPY vendor ${FUNCTION_DIR}/vendor

# RUN bundle config

# Install the gems for the project
RUN bundle install --jobs=4 && rm -Rf vendor/bundle/ruby/*/cache vendor/bundle/ruby/*/gems/*/test


# Copy over rest of project
COPY . ${FUNCTION_DIR}/



# Compile the assets
RUN if [[ "${COMPILE_ASSETS}" = "true" ]] ; then bin/rails assets:precompile ; fi

# Stage 3 - final runtime image
# Grab a fresh copy of the base image
FROM base

# Include global arg in this stage of the build
ARG FUNCTION_DIR
ARG RUNTIME_PKGS

# Set working directory to function root directory
WORKDIR ${FUNCTION_DIR}

RUN apk add ${RUNTIME_PKGS}

# Copy in the built dependencies
COPY --from=build-image ${FUNCTION_DIR} ${FUNCTION_DIR}

ENTRYPOINT ["/usr/local/bin/bundle", "exec", "bin/aws_lambda_ric"]
CMD ["app.handler"]