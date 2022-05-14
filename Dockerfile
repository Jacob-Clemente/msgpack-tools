# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y g++

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y unzip

## Add source code to the build stage.
ADD . /msgpack-tools
WORKDIR /msgpack-tools

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN ./configure
RUN make

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /msgpack-tools/msgpack2json /
COPY --from=builder /msgpack-tools/json2msgpack /
