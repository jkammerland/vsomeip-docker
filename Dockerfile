FROM alpine:3.19.1

WORKDIR /home

RUN \
    --mount=type=cache,target=/var/cache/apk \
    apk add \
    pkgconfig \
    bash \
    curl \
    unzip \
    tar \
    zip \
    git \
    gcc \
    g++ \
    socat \
    boost-dev \
    make \
    cmake \
    build-base \
    openssh-client \
    python3 && \
    \ 
    # Donwload and install latest ninja version
    git clone https://github.com/ninja-build/ninja.git && cd ninja && git checkout release && ./configure.py --bootstrap && cp ninja /usr/bin/
#rm -rf /var/cache/apk/*

RUN \
    --mount=type=cache,target=/var/cache/builds \
    # Download and install latest custom vsomeip fork
    git clone https://github.com/jkammerland/vsomeip.git && \
    cd vsomeip && git submodule update --init --recursive && ./vcpkg/bootstrap-vcpkg.sh -disableMetrics && \
    mkdir build && cd build && \
    cmake -E env CXXFLAGS="-Wno-error=stringop-overflow" \ 
    # -DENABLE_SIGNAL_HANDLING=1  so that CTRL+C works, without any problems
    # (otherwise it might be that the shared memory segment /dev/shm/vsomeip is not be correctly removed when you stop the application with Ctrl-C).
    cmake .. -DBoost_INCLUDE_DIR=/usr/include/boost -DENABLE_SIGNAL_HANDLING=1 && \
    make -j && make install

RUN \
    --mount=type=cache,target=/var/cache/builds \
    cd vsomeip && cd examples && cd hello_world && mkdir build && cd build && \
    cmake -E env CXXFLAGS="-Wno-error=stringop-overflow" \
    cmake .. -DBoost_INCLUDE_DIR=/usr/include/boost && \
    make -j

COPY ./ip_env.sh .
WORKDIR /home/vsomeip/examples/hello_world/build

# Add metadata
LABEL maintainer="jkammerland@gmail.com" \
    version="0.1" \
    description="Custom vsomeip build with Boost on Alpine Linux"

# HOST1:
# VSOMEIP_CONFIGURATION=../helloworld-local.json \
# VSOMEIP_APPLICATION_NAME=hello_world_service \
# ./hello_world_service

# HOST1:
# VSOMEIP_CONFIGURATION=../helloworld-local.json \
# VSOMEIP_APPLICATION_NAME=hello_world_client \
# ./hello_world_client