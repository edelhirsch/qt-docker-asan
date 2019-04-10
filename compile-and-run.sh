#!/bin/bash

INTERMEDIATE_NAME=qt-asan-ubsan-intermediate
NAME=qt-asan-ubsan

docker build -t $INTERMEDIATE_NAME .
docker run --cap-add SYS_PTRACE --cidfile $INTERMEDIATE_NAME.cid $INTERMEDIATE_NAME
CID=`cat $INTERMEDIATE_NAME.cid`
rm $INTERMEDIATE_NAME.cid
docker commit -c 'ENTRYPOINT ["/bin/bash"]' $CID $NAME
