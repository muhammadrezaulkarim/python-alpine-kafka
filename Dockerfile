FROM python:3.6.4-alpine3.7

ARG VERSION=0.11.4

RUN apk add --no-cache \
        bash \
        ca-certificates \
        g++ \
        git \
        libressl \
        libressl-dev \
        linux-headers \
        make \
        musl-dev \
        zlib-dev

RUN wget https://github.com/edenhill/librdkafka/archive/v$VERSION.tar.gz \
        -O /tmp/librdkafka-$VERSION.tar.gz && \
    cd /tmp/ && \
    tar zxf librdkafka-$VERSION.tar.gz && \
    cd librdkafka-$VERSION && \
    ./configure && \
    make && \
    make install

ENV PYTHONUNBUFFERED 1

COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

CMD ["python"]
