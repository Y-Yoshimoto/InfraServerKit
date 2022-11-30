#!/bin/bash
# ini
label-studio-ml init mm-detector --from /usr/src/mmdetection/mmdetection.py --force
# run
label-studio-ml start mm-detector --with \
hostname=$LABEL_STUDIO_HOSTNAME \
access_token=$LABEL_STUDIO_API_KEY \
score_threshold=$SCORE_THRESHOLD \
config_file=/mmdetection/configs/faster_rcnn/faster_rcnn_r50_fpn_1x_coco.py \
checkpoint_file=/mmdetection/checkpoints/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth

# http://mlbackend:9090