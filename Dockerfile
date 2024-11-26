FROM ubuntu:18.04 as builder

RUN apt-get update && \
    apt-get install -y g++ automake make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

RUN linux32 ./configure && \
    linux32 make


FROM alpine as runner

WORKDIR /app

COPY --from=builder /app/stegdetect /app/stegbreak /app/stegcompare /app/stegdeimage /app/

RUN apk add gcompat
# 导出四个文件到容器外部
