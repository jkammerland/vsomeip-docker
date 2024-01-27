FROM ubuntu:22.04

WORKDIR /home

RUN \
    apt-get update && \
    apt-get install -y \
    pkg-config \
    curl \
    unzip \
    tar \
    zip \
    git \
    gcc \
    g++ \
    # Install boost
    libboost-all-dev \
    make \
    cmake \
    build-essential \
    openssh-client \
    python3 && \
    \ 
    # Donwload and install latest ninja version
    git clone https://github.com/ninja-build/ninja.git && cd ninja && git checkout release && ./configure.py --bootstrap && cp ninja /usr/bin/ && \
    \
    # Download and install latest vcpkg version
    git clone https://github.com/jkammerland/vsomeip.git && \
    cd vsomeip && git submodule update --init --recursive && ./vcpkg/bootstrap-vcpkg.sh -disableMetrics && \
    mkdir build && cd build && cmake .. -DBoost_INCLUDE_DIR=/usr/include/boost && make -j && make install
#rm -rf /var/cache/apk/*

# RUN cd vsomeip && mkdir build && cd build && cmake .. 