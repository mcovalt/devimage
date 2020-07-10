FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' /etc/dpkg/dpkg.cfg.d/excludes \
 && apt-get update \
 && apt-get install -y \
        apt-utils \
    2> /dev/null \
 && apt-get install -y \
        locales \
        man \
        manpages-posix \
 && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
 && export LANG=en_US.utf8 \
 && apt-get install -y -o Dpkg::Options::="--force-overwrite" \
        bat \
        ripgrep \
 && apt-get install -y \
        curl \
        fd-find \
        fish \
        git \
        gnupg \
        htop \
        jq \
        less \
        openssh-client \
        tmux \
        tzdata \
        unzip \
        vim \
 && rm -rf /var/lib/apt/lists/* \
 # curlie -- https://github.com/rs/curlie
 && curl -sL https://api.github.com/repos/rs/curlie/releases/latest \
    | jq -r '.assets[].browser_download_url' \
    | grep 'linux_amd64.tar.gz$' \
    | xargs curl -sL \
    | tar -xOzf - curlie \
    > /usr/local/bin/curlie && chmod +x /usr/local/bin/curlie \
 # exa -- https://github.com/ogham/exa
 && curl -sL https://api.github.com/repos/ogham/exa/releases/latest \
    | jq -r '.assets[].browser_download_url' \
    | grep 'exa-linux-x86_64' \
    | xargs curl -sL \
    | funzip \
    > /usr/local/bin/exa && chmod +x /usr/local/bin/exa \
 # s6-overlay -- https://github.com/just-containers/s6-overlay
 && curl -sL https://api.github.com/repos/just-containers/s6-overlay/releases/latest \
    | jq -r '.assets[].browser_download_url' \
    | grep 'amd64.tar.gz$' \
    | xargs curl -sL \
    | tar -xzf - -C / \
 # starship -- https://github.com/starship/starship
 && curl -sL https://api.github.com/repos/starship/starship/releases/latest \
    | jq -r '.assets[].browser_download_url' \
    | grep 'x86_64-unknown-linux-gnu.tar.gz$' \
    | xargs curl -sL \
    | tar -xOzf - starship \
    > /usr/local/bin/starship && chmod +x /usr/local/bin/starship \
 && chsh -s /usr/bin/fish \
 && ln -s /usr/bin/sh /bin/sh \
 && ln -s /usr/bin/bash /bin/bash

COPY s6 /etc
COPY config/config.fish /root/.config/fish/config.fish
COPY config/starship.toml /root/.config/starship.toml
COPY config/vimrc /root/.vimrc
COPY config/tmux.conf /root/.tmux.conf

ENV S6_KEEP_ENV=1 \
    LANG=en_US.utf8

WORKDIR /workspace
VOLUME ["/root/.local/share/fish/fish_history"]
ENTRYPOINT [ "/init" ]