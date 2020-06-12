FROM qingfeng1987/k8s-gerrit-gerrit-base:latest

USER root

COPY dependencies/* /var/tools/
WORKDIR /var/tools

RUN apk update && \
    apk add --no-cache \
      python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel pipenv && \
    pipenv install --python 3.7.3 --system

COPY tools/* /var/tools/
COPY config/* /var/config/

COPY tools/* /var/tools/

USER gerrit

ENTRYPOINT ["/var/tools/gerrit_init.py", "-s", "/var/gerrit"]
CMD ["-c", "/var/config/default.config.yaml"]
