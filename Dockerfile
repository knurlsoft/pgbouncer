ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION} AS target

FROM target as build_stage
ARG PGBOUNCER_VERSION

RUN apk --update add \
    build-base \
    libevent-dev \
    openssl-dev \
    c-ares-dev

WORKDIR /src
ADD https://www.pgbouncer.org/downloads/files/${PGBOUNCER_VERSION}/pgbouncer-${PGBOUNCER_VERSION}.tar.gz pgbouncer.tar.gz
RUN tar -xf pgbouncer.tar.gz --strip 1
RUN ./configure --prefix=/pgbouncer
RUN make -j$(nproc)
RUN make install

FROM target
RUN apk --update add \
    libevent \
    openssl \
    c-ares

WORKDIR /
COPY --from=build_stage /pgbouncer/bin/. /usr/bin
COPY entrypoint.sh ./
ENTRYPOINT ["./entrypoint.sh"]
