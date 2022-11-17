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
RUN git clone https://github.com/open-mmlab/mmdetection.git \
    && mim download mmdet --config yolov3_mobilenetv2_320_300e_coco --dest /mmdetection/

WORKDIR /usr/src
COPY ./src/* /usr/src
VOLUME /usr/src

# ENTRYPOINT ["python", "main.py"]
ENTRYPOINT ["tail", "-f", "/dev/null"]