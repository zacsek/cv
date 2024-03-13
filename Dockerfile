FROM mfisherman/miktex:latest

LABEL version="1.0"
LABEL description="miktex repackaged for my usecase"

ARG user=miktex
ARG group=miktex
ARG uid=1000
ARG gid=1000

ARG miktex_work=/data

VOLUME [ "${miktex_work}" ]
WORKDIR ${miktex_work}

RUN groupadd -g ${gid} ${group} \
    && useradd -u ${uid} -g ${gid} -m -s /bin/bash ${user}

USER ${user}

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash"]
