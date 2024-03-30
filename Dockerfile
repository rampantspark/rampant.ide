# Use a base image with Neovim pre-installed
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
    bottom

# Clone AstroNvim and Rampant.nvim repositories
RUN git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim && \
    git clone https://github.com/rampantspark/rampant.nvim.git ~/.config/nvim/lua/user

# Expose any ports required by Neovim plugins (if applicable)
EXPOSE 22

# Set the entry point to launch Neovim
CMD ["tmux"]

