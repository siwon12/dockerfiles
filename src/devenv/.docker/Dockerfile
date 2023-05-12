ARG BUILD_FROM="entelecheia/devenv-base:latest-nvtorch"
FROM $BUILD_FROM

USER root

# Add a non-root user to a container
ARG USERNAME="dev"
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && adduser --uid $USER_UID --gid $USER_GID --force-badname --disabled-password --gecos "" $USERNAME  \
    && echo "$USERNAME:$USERNAME" | chpasswd \
    && adduser $USERNAME sudo \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# install dotfiles
ARG USER_FULLNAME="Dev User"
ARG USER_EMAIL="dev@domain.com"
ARG GITHUB_USERNAME=""
ARG WORKSPACE_LOCATION="/"
ARG WORKSPACE_ROOT="/workspace"
ARG SYSTEM_HOSTNAME="dev-container"

ENV USER_FULLNAME $USER_FULLNAME
ENV USER_EMAIL $USER_EMAIL
ENV GITHUB_USERNAME $GITHUB_USERNAME
ENV WORKSPACE_LOCATION $WORKSPACE_LOCATION
ENV WORKSPACE_ROOT $WORKSPACE_ROOT
ENV SYSTEM_HOSTNAME $SYSTEM_HOSTNAME
ENV DOTFILES_APPLY_ROOTMOI=0
ENV DOTFILES_USE_CODE=1
ENV DOTFILES_USE_PYTHON_TOOLS=1
ENV REMOTE_CONTAINERS=1
# ENV DOTFILES_DEBUG=1

ENV PIP_DEFAULT_TIMEOUT 100
ENV DS_BUILD_FUSED_ADAM 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV KMP_DUPLICATE_LIB_OK TRUE

USER $USERNAME
RUN sudo rm -rf $WORKSPACE_ROOT && sudo mkdir -p $WORKSPACE_ROOT
RUN sudo chown -R $USERNAME:$USERNAME $WORKSPACE_ROOT
RUN sh -c "$(wget -qO- https://dotfiles.entelecheia.ai/install)"

# install requirements
COPY .docker/scripts/requirements-dev.txt .
RUN pip install --no-cache-dir -r requirements-dev.txt

# set workdir to user home
WORKDIR /home/$USERNAME
COPY ./.docker/scripts/ ./scripts/
RUN sudo chmod 755 ./scripts/devenv-entrypoint.sh

WORKDIR $WORKSPACE_ROOT
CMD ["zsh"]
