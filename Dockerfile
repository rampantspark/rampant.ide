# Use Arch Linux base image
FROM archlinux:latest

# Install required packages
RUN pacman --noconfirm -Syyu \
    neovim \
    git \
    nerd-fonts \
    ripgrep \
    gdu \
    python3 \
    nodejs \
    tmux \
    lazygit \
    bottom \
    base-devel \
    go \
    sudo

# Clone AstroNvim and rampant.nvim repositories
RUN git clone --depth 1 https://github.com/rampantspark/rampant.nvim.git ~/.config/nvim

# Setup tmux config
RUN mkdir ~/.config/tmux && \
    curl -o ~/.config/tmux/tmux.conf "https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf" && \
    curl -o ~/.config/tmux/tmux.conf.local "https://raw.githubusercontent.com/rampantspark/rampant.dots/main/themes/rampant-gruvbox-x11/tmux/tmux.conf.local" 

# Create yay user
RUN useradd -ms /bin/bash yay

# Allow the yay user to run sudo without a password
RUN echo 'yay ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER yay

# Setup yay
RUN cd /tmp && \
    git clone https://aur.archlinux.org/yay.git && \
    cd ./yay && \
    makepkg -si --noconfirm

# Install yay for additional dependencies
RUN yay -Syyu --noconfirm

USER root

# Expose any ports required by Neovim plugins (if applicable)
EXPOSE 22

# Set the entry point to launch Neovim
CMD ["tmux"]
