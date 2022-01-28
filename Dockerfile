FROM dart:2.15.1-sdk as builder
WORKDIR /root
RUN apt-get update \
  && apt-get install -y git-all \
  && apt-get install -y unzip \
  && apt-get install -y protobuf-compiler
RUN git clone https://github.com/flutter/flutter.git -b stable
ENV PATH="/root/flutter/bin:/root/flutter/.pub-cache/bin:${PATH}" 
RUN flutter precache
RUN flutter pub global activate protoc_plugin
