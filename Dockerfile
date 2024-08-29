FROM ubuntu:20.04

ARG USERNAME=ubuntu

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

COPY . ./app
RUN sudo ln -sf /bin/zsh /bin/sh
RUN sudo chown -R $USERNAME:$USERNAME ./app && chmod -R +x ./app

RUN touch /home/$USERNAME/.zshrc && \
    echo 'echo "You are currently using: $(ps -p $$ -o comm=)"' >> /home/$USERNAME/.zshrc

# Set the default shell to zsh
CMD ["zsh"]
