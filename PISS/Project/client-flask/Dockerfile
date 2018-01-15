FROM python:alpine3.6
COPY . /code
WORKDIR /code
RUN apk upgrade --update && apk add bash \
    git \
    g++ \
    autoconf \
    automake \
    make \
    libtool \
    libnotify \
    nasm \
    zlib-dev \
    freetype-dev \
    lcms2-dev \
    tiff-dev \
    tk-dev \
    tcl-dev
RUN pip install wheel -r requirements.txt
