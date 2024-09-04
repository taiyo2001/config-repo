FROM ubuntu:20.04

ARG USERNAME=ubuntu
ARG REPO_NAME=config-repo

RUN apt-get update && apt-get install -y \
    zsh \
    sudo \
    curl \
    vim \
    git \
    && apt-get clean

# Create a new user and grant sudo privileges
RUN useradd -m -s /bin/zsh $USERNAME && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/$USERNAME

USER $USERNAME

COPY . /home/$USERNAME/$REPO_NAME
RUN sudo ln -sf /bin/zsh /bin/sh
RUN sudo chown -R $USERNAME:$USERNAME ./$REPO_NAME && chmod -R +x ./$REPO_NAME

RUN touch /home/$USERNAME/.zshrc && \
    echo 'echo "You are currently using: $(ps -p $$ -o comm=)"' >> /home/$USERNAME/.zshrc

# Set the default shell to zsh
CMD ["zsh"]
