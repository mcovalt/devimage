FROM alpine:3.12

RUN apk add --no-cache \
        curl \
        exa \
        fd \
        fish \
        git \
        gnupg \
        htop \
        jq \
        less \
        openssh-client \
        ripgrep \
        tmux \
        tzdata \
        vim \
    && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing bat \
    && curl -sL https://api.github.com/repos/rs/curlie/releases/latest \
     | jq -r '.assets[].browser_download_url' \
     | grep "linux_amd64.tar.gz" \
     | xargs curl -sL \
     | tar -xOzf - curlie \
     > /usr/local/bin/curlie && chmod +x /usr/local/bin/curlie \
    && curl -sL https://api.github.com/repos/starship/starship/releases/latest \
     | jq -r '.assets[].browser_download_url' \
     | grep "x86_64-unknown-linux-musl.tar.gz" \
     | xargs curl -sL \
     | tar -xOzf - starship \
     > /usr/local/bin/starship && chmod +x /usr/local/bin/starship \
    && curl -sL https://api.github.com/repos/just-containers/s6-overlay/releases/latest \
     | jq -r '.assets[].browser_download_url' \
     | grep "amd64.tar.gz" \
     | xargs curl -sL \
     | tar -xzf - -C / \
    && sed -i 's/\/bin\/ash/\/usr\/bin\/fish/g' /etc/passwd

COPY s6 /etc
COPY config/config.fish /root/.config/fish/config.fish
COPY config/starship.toml /root/.config/starship.toml
COPY config/vimrc /root/.vimrc
COPY config/tmux.conf /root/.tmux.conf

ENV S6_KEEP_ENV=1

WORKDIR /workspace
ENTRYPOINT [ "/init" ]