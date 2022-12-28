# Start docker container

CONTAINER_RESULT_DIR=/home/thebesttv/Static-Bug-Detectors-ASE-Artifact/analyzers/results

SBLT_REPORT_DIR=sblt-proj-reports
SBHT_REPORT_DIR=sbht-proj-reports
INFER_REPORT_DIR=infer-proj-reports
NULLAWAY_REPORT_DIR=nullaway-proj-reports
CF_REPORT_DIR=checkerframework-proj-reports
ERADICATE_REPORT_DIR=eradicate-proj-reports

docker run --rm -it \
       -p 127.0.0.1:50022:22 \
       -v /var/run/docker.sock:/var/run/docker.sock \
       -v $SBLT_REPORT_DIR:$CONTAINER_RESULT_DIR/$SBLT_REPORT_DIR \
       -v $SBHT_REPORT_DIR:$CONTAINER_RESULT_DIR/$SBHT_REPORT_DIR \
       -v $INFER_REPORT_DIR:$CONTAINER_RESULT_DIR/$INFER_REPORT_DIR \
       -v $NULLAWAY_REPORT_DIR:$CONTAINER_RESULT_DIR/$NULLAWAY_REPORT_DIR \
       -v $CF_REPORT_DIR:$CONTAINER_RESULT_DIR/$CF_REPORT_DIR \
       -v $ERADICATE_REPORT_DIR:$CONTAINER_RESULT_DIR/$ERADICATE_REPORT_DIR \
       thebesttv/real-world:main \
       /bin/bash
