FROM ubuntu:14.04

MAINTAINER Tobias Hartwich <mail@tha.io>

RUN mkdir -p /opt/virtualenvs
ENV WORKON_HOME /opt/virtualenvs

RUN apt-get update && apt-get install -y \
    python2.7 \
    python-pip \
    python-virtualenv \
    python-psycopg2 \
    python2.7-dev \
    libyaml-0-2 \
    libjpeg8 \
    libjpeg-dev \
    libfreetype6 \
    libfreetype6-dev \
    zlib1g-dev \
    tesseract-ocr \
    tesseract-ocr-deu \
    unpaper \
    libreoffice \
    ghostscript \
    libpng-dev \
    libtiff-dev \
    poppler-utils \
    supervisor \
    imagemagick \
    python-wand \
    graphicsmagick \
    python-pgmagick \
    webp


RUN pip install mayan-edms

VOLUME /usr/local/lib/python2.7/dist-packages/mayan

ADD base.py /usr/local/lib/python2.7/dist-packages/mayan/settings/base.py
ADD api.py /usr/local/lib/python2.7/dist-packages/mayan/apps/ocr/api.py
ADD tesseract.py /usr/local/lib/python2.7/dist-packages/mayan/apps/ocr/backends/tesseract.py
#RUN mayan-edms.py syncdb
#RUN mayan-edms.py migrate
EXPOSE 8000
CMD mayan-edms.py runserver 0.0.0.0:8000
