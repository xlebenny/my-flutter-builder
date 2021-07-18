FROM google/dart-runtime-base:2.14.0-321.0.dev as builder
WORKDIR /root
RUN apt-get update \
  && apt-get install -y git-all \
  && apt-get install unzip
RUN git clone https://github.com/flutter/flutter.git -b stable
ENV PATH="/root/flutter/bin:/root/flutter/.pub-cache/bin:${PATH}" 
RUN flutter precache
