# This is a sample Dockerfile you can modify to deploy your own app based on face_recognition

FROM resin/raspberry-pi-python:3
COPY pip.conf /root/.pip/pip.conf
RUN apt-get -y update
RUN apt-get install -y --fix-missing \
    build-essential \
    cmake \
    gfortran \
    git \
    wget \
    curl \
    graphicsmagick \
    libgraphicsmagick1-dev \
    libatlas-dev \
    libavcodec-dev \
    libavformat-dev \
    libboost-all-dev \
    libgtk2.0-dev \
    libjpeg-dev \
    liblapack-dev \
    libswscale-dev \
    pkg-config \
    python3-dev \
    zip \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*
RUN python3 -m ensurepip --upgrade && pip3 install --upgrade picamera[array] dlib

# The rest of this file just runs an example script.

# If you wanted to use this Dockerfile to run your own app instead, maybe you would do this:
# COPY . /root/your_app_or_whatever
# RUN cd /root/your_app_or_whatever && \
#     pip3 install -r requirements.txt
# RUN whatever_command_you_run_to_start_your_app

RUN git clone --single-branch https://github.com/ageitgey/face_recognition.git
RUN cd /face_recognition && \
    pip3 install -r requirements.txt && \
    python3 setup.py install

CMD cd /face_recognition/examples && \
    python3 recognize_faces_in_pictures.py

