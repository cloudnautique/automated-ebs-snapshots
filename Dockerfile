FROM alpine

WORKDIR /tmp/build
COPY ./ /tmp/build

RUN apk add --no-cache --update python py-pip \
    && pip install wheel \
    && python setup.py bdist_wheel \
    && rm -rf /var/cache/apk/*

FROM alpine

COPY --from=0 /tmp/build/dist/automated_ebs_snapshots-*.whl .

RUN apk add --no-cache --update python py-pip \
    && pip install automated_ebs_snapshots-*.whl \
    && rm -rf /var/cache/apk/* automated_ebs_snapshots-*.whl

ENTRYPOINT ["/usr/bin/automated-ebs-snapshots"]
