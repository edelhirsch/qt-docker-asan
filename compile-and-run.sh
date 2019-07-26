#!/bin/bash

INTERMEDIATE_NAME=qt-asan-ubsan-intermediate
NAME=qt-asan-ubsan

docker build -t $INTERMEDIATE_NAME .
docker run --cap-add SYS_PTRACE --cidfile $INTERMEDIATE_NAME.cid $INTERMEDIATE_NAME
CID=`cat $INTERMEDIATE_NAME.cid`
docker commit -c 'ENTRYPOINT ["/bin/bash"]' $CID $NAME
rm $INTERMEDIATE_NAME.cid
# to check: docker run -it qt-asan-ubsan
# to push to Docker Hub:
# `docker images` -> remember image ID
# docker tag d738e8f32e9c edelhirsch/qt-asan-ubsan:v5.12.4 # d738... is the image ID
# docker push edelhirsch/qt-asan-ubsan
