ARG ALPINE_VERSION=${ALPINE_VERSION:-latest}

FROM  golang:1.23-alpine${ALPINE_VERSION}
## AS secsipidbuilder

RUN <<HEREDOC
    apk add --no-cache make gcc musl-dev git abuild alpine-sdk apk-tools \
    musl-dev gpg doas ruby-dev

    adduser --disabled-password builder
    addgroup builder wheel
    addgroup builder abuild
    echo "permit nopass :wheel" > /etc/doas.d/builder > /etc/doas.d/builder.conf

    gem update --system
    gem install package_cloud

HEREDOC

USER builder

COPY --chown=builder:builder script/build_secsipid_package.sh /home/builder/build_secsipid_package.sh
COPY --chown=builder:builder APKBUILD /home/builder/secsipid

WORKDIR /home/builder/secsipid

ENV CGO_ENABLED=1

#FROM alpine:3.19

#COPY --from=secsipidbuilder /go/src/github.com/asipto/secsipidx/csecsipid/* /csecsipid/
#COPY --from=secsipidbuilder /go/bin/secsipidx /bin/


