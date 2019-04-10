#!/bin/bash

docker build . -t qt-asan-ubsan
docker run --cap-add SYS_PTRACE qt-asan-ubsan
