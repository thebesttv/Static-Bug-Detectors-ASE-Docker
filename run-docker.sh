# Start docker container

CONTAINER_RESULT_DIR=/home/thebesttv/Static-Bug-Detectors-ASE-Artifact/analyzers/results

REPORT_DIR=sblt-proj-reports

docker run --rm -it \
       -p 127.0.0.1:50022:22 \
       -v /var/run/docker.sock:/var/run/docker.sock \
       -v $REPORT_DIR:$CONTAINER_RESULT_DIR/$REPORT_DIR \
       thebesttv/real-world:main \
       /bin/bash
