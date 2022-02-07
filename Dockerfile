FROM ubuntu:22.04 as glibc

FROM alpine:3.15.0 as runtime

COPY --from=glibc /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2
COPY --from=glibc /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libc.so.6
COPY --from=glibc /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/libm.so.6
COPY --from=glibc /lib/x86_64-linux-gnu/libpthread.so.0 /lib/x86_64-linux-gnu/libpthread.so.0
COPY --from=glibc /lib/x86_64-linux-gnu/libdl.so.2 /lib/x86_64-linux-gnu/libdl.so.2
#nslookup
COPY --from=glibc /etc/nsswitch.conf /etc/nsswitch.conf
COPY --from=glibc /etc/hosts /etc/hosts
COPY --from=glibc /etc/resolv.conf /etc/resolv.conf
COPY --from=glibc /lib/x86_64-linux-gnu/libnss_dns.so.2 /lib/x86_64-linux-gnu/libnss_dns.so.2
COPY --from=glibc /lib/x86_64-linux-gnu/libresolv.so.2 /lib/x86_64-linux-gnu/libresolv.so.2

RUN apk add \
 bash=5.1.8-r0 \
 unzip=6.0-r9 \
 git=2.34.1-r0 \
 file=5.41-r0 \
 which=2.21-r2 \
 xz=5.2.5-r0 \
 curl=7.80.0-r0 \
 protobuf=3.18.1-r1

ENV PATH="/root/flutter/bin:/root/flutter/.pub-cache/bin:${PATH}"
RUN git clone https://github.com/flutter/flutter.git --branch=2.10.0 --depth=1 \
 && flutter precache \
 && flutter pub global activate protoc_plugin
