ARG BUILD_FROM="entelecheia/devenv:latest"
FROM $BUILD_FROM

# install requirements
RUN pip install -U xformers
# # (Optional) Makes the build much faster
# RUN pip install ninja
# # Set TORCH_CUDA_ARCH_LIST if running and building on different GPU types
# RUN pip install -v -U git+https://github.com/facebookresearch/xformers.git@main#egg=xformers
# # (this can take dozens of minutes)

# set workdir to user home
WORKDIR /home/$USERNAME
COPY ./.docker/scripts/ ./scripts/
RUN sudo chmod 755 ./scripts/webui.sh

WORKDIR $WORKSPACE_ROOT
CMD ["zsh"]
