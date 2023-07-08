FROM python:3.9-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache git openssh git-lfs

RUN git lfs install

MKDIR /scripts

# add scripts to path
# we still want to make this scripts are executable from any part
ENV PATH="/scripts:${PATH}"

COPY git-filter-repo /scripts/git-filter-repo
COPY src/setup-ssh.sh /scripts/setup-ssh.sh
COPY src/mirror.sh /scripts/mirror.sh
COPY src/cleanup.sh /scripts/cleanup.sh
COPY src/modules.sh /scripts/modules.sh

ENTRYPOINT ["/mirror.sh"]
