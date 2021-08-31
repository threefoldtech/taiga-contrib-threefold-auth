ARG TAIGA_VERSION=latest
ARG RELEASE=main
FROM taigaio/taiga-back:${TAIGA_VERSION}
RUN apt-get update && apt-get install git -y
RUN git clone https://github.com/threefoldtech/taiga-contrib-threefold-auth && cd taiga-contrib-threefold-auth && git checkout ${RELEASE}
RUN cd taiga-contrib-threefold-auth/back; pip install -e .
COPY config.py /taiga-back/settings/config.py

ENV PUBLIC_REGISTER_ENABLED=False
# change this key. check the documentation for more info.
ENV THREEFOLD_API_APP_SECRET="2W/qhWFeMF6XawIPuEnJ3dWge49bYZNhSsELF64daus="
# optional env settings. If these are not set, then hardcoded values are used
ENV THREEFOLD_URL=""
ENV THREEFOLD_OPENKYC_URL=""
