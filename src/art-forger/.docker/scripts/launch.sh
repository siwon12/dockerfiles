#!/usr/bin/env bash
#########################################################
# Uncomment and change the variables below to your need:#
#########################################################

# Install directory without trailing slash
install_dir=${AFG_INSTALL_ROOT:-"/workspace/projects"}
clone_dir=${AFG_CLONE_DIR:-"brushstroke_engine"}
export AFG_MODEL=style1
export GIT="git"
export LAUNCH_SCRIPT="neube_run.sh"

# Do not reinstall existing pip packages on Debian/Ubuntu
export PIP_IGNORE_INSTALLED=0

export PATH="$HOME/.local/bin:$PATH"

export
# Pretty print
delimiter="################################################################"

printf "\n%s\n" "${delimiter}"
printf "\e[1m\e[32mLaunch script for Neural Brushstroke\n"
printf "\n%s\n" "${delimiter}"

cd "${install_dir}"/ || {
    printf "\e[1m\e[31mERROR: Can't cd to %s/, aborting...\e[0m" "${install_dir}"
    exit 1
}
if [[ -d "${clone_dir}" ]]; then
    cd "${clone_dir}"/ || {
        printf "\e[1m\e[31mERROR: Can't cd to %s/%s/, aborting...\e[0m" "${install_dir}" "${clone_dir}"
        exit 1
    }
else
    printf "\n%s\n" "${delimiter}"
    printf "Clone %s" "${AFG_GITHUB_REPO}"
    printf "\n%s\n" "${delimiter}"
    "${GIT} clone https://github.com/${AFG_GITHUB_USERNAME}/${AFG_GITHUB_REPO}.git ${clone_dir}"
    cd "${clone_dir}"/ || {
        printf "\e[1m\e[31mERROR: Can't cd to %s/%s/, aborting...\e[0m" "${install_dir}" "${clone_dir}"
        exit 1
    }
fi

cd "${install_dir}"/"${clone_dir}"/ || {
    printf "\e[1m\e[31mERROR: Can't cd to %s/%s/, aborting...\e[0m" "${install_dir}" "${clone_dir}"
    exit 1
}
printf "\n%s\n" "${delimiter}"
printf "Check out %s branch" "${AFG_GITHUB_BRANCH}"
printf "\n%s\n" "${delimiter}"
"${GIT}" fetch --all
"${GIT}" checkout -B "${AFG_GITHUB_BRANCH}" || {
    printf "\e[1m\e[31mERROR: Can't checkout %s branch, aborting...\e[0m" "${AFG_GITHUB_BRANCH}"
    exit 1
}

# download model to models/ folder if it doesn't exist
GDOWN_ID="1Ao-3LZPmOSCZA7GIm5piQ3T6PK63NCZe"
MODEL_DIR="${install_dir}"/"${clone_dir}"/models
MODEL_ARCHIVE="models.zip"
if [[ ! -d "${MODEL_DIR}" ]]; then
    printf "\n%s\n" "${delimiter}"
    printf "Download models from Google Drive with id %s" "${GDOWN_ID}"
    printf "\n%s\n" "${delimiter}"
    # download model using gdown
    # if gdown is not installed, install it
    if ! command -v gdown &>/dev/null; then
        printf "\n%s\n" "${delimiter}"
        printf "Install gdown"
        printf "\n%s\n" "${delimiter}"
        pip install gdown --user
    fi
    gdown -O "${MODEL_ARCHIVE}" "${GDOWN_ID}"
    # unzip model
    unzip "${MODEL_ARCHIVE}" -d .
    rm "${MODEL_ARCHIVE}"
fi

printf "\n%s\n" "${delimiter}"
printf "Launching %s" "${LAUNCH_SCRIPT}"
printf "\n%s\n" "${delimiter}"
bash "${LAUNCH_SCRIPT}" "${AFG_MODEL}" "$@"
