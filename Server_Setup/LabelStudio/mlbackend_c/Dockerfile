# FROM node:latest
FROM python:3.10-slim 
#AS builder
LABEL maintaner='y-yoshimoto'
## Install build tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends git gcc g++\
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && update-ca-certificates
RUN pip install --upgrade pip \
    && pip install --no-cache-dir numpy setuptools wheel Cython\
    && pip freeze > requirements.lock
# Build pycocotools
RUN pip download --no-dependencies pycocotools \
    && mkdir -p pycocotools && tar -xvf ./pycocotools-*.tar.gz -C pycocotools --strip-components 1 \
    && cd /pycocotools \
    && python setup.py bdist_wheel \
    && cp /pycocotools/dist/pycocotools-*.whl /tmp/ \
    && cd /


# Install run lib
RUN apt-get update \
    && apt-get install -y --no-install-recommends libopencv-dev libgl1-mesa-dev\
    && apt-get -y clean
COPY requirements.txt ./
RUN pip install --upgrade pip \
    && pip install torch torchvision torchaudio \
    && pip install --no-cache-dir /tmp/*.whl \
    && pip install --no-cache-dir -r requirements.txt \
    && pip freeze > requirements.lock

# Build mmcv-full
RUN git clone https://github.com/open-mmlab/mmcv.git \
    && cd /mmcv \
    && pip install -r requirements/optional.txt \
    && MMCV_WITH_OPS=1 pip install --user -e . \
    && python .dev_scripts/check_installation.py \
    && cd /

RUN pip install --upgrade pip \
    && pip install openmim \
    && mim install mmdet \
    && pip freeze > requirements.lock

# git clone mmdetection
RUN git clone https://github.com/open-mmlab/mmdetection.git 
#\    && mim download mmdet yolov3_mobilenetv2_320_300e_coco --dest /mmdetection/

# make mlBackend
ENV LABEL_STUDIO_HOSTNAME=http://labelstudio:8080
RUN mim download mmdet --config faster_rcnn_r50_fpn_1x_coco --dest /mmdetection/checkpoints \ 
    && git clone https://github.com/heartexlabs/label-studio-ml-backend \
    && cd label-studio-ml-backend \
    && pip install redis rq boto3 \
    && pip install -U -e . \
    && label-studio-ml init coco-detector --from label_studio_ml/examples/mmdetection/mmdetection.py --force\
    && cd /
# https://github.com/heartexlabs/label-studio-ml-backend#create-your-own-ml-backend
# https://labelstud.io/tutorials/object-detector.html
# https://github.com/heartexlabs/label-studio-ml-backend/blob/250e2c08fefbb32723105b7e53ade9b2441a69ad/label_studio_ml/examples/simple_text_classifier/README.md

# label-studio-ml start coco-detector --with \
#    config_file=/mmdetection/configs/faster_rcnn/faster_rcnn_r50_fpn_1x_coco.py \
#    checkpoint_file=/mmdetection/checkpoints/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth

EXPOSE 9090

#WORKDIR /usr/src
COPY ./src/* /usr/src
VOLUME /usr/src
WORKDIR /label-studio-ml-backend

ENTRYPOINT ["label-studio-ml", "start", "coco-detector", "--with"]
CMD ["config_file=/mmdetection/configs/faster_rcnn/faster_rcnn_r50_fpn_1x_coco.py","checkpoint_file=/mmdetection/checkpoints/faster_rcnn_r50_fpn_1x_coco_20200130-047c8118.pth"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]