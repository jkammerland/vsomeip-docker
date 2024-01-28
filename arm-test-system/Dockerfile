FROM arm64v8/alpine:3.19.1

# Additional Alpine configuration can be added here
RUN apk add --no-cache \
    bash \
    curl \
    git \
    build-base \
    gcc \
    make \
    cmake \
    openssh-client \
    python3 \
    tar \
    unzip \
    wget \
    zip

WORKDIR /home
COPY ./hello.c .
RUN gcc -o hello hello.c