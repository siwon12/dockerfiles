ARG BUILD_FROM="nvcr.io/nvidia/pytorch:23.04-py3"
FROM $BUILD_FROM

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y fontconfig fonts-nanum curl git tzdata locales locales-all \
        imagemagick ffmpeg sudo software-properties-common openssh-server \
    && add-apt-repository ppa:git-core/ppa -y \
    && apt-get update \
    && apt-get -y install --no-install-recommends git \
    && apt-get autoremove -y \
    && apt-get clean -y

# Set up locale
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || true
# fix sudo setrlimit(RLIMIT_CORE) error
RUN echo "Set disable_coredump false" > /etc/sudo.conf

CMD ["bash"]
