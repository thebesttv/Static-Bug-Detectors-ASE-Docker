FROM ubuntu:16.04

# 对apt加入https支持, 并使用清华源 (使用 printf 打印多行)
# https://unix.stackexchange.com/a/263803
# https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/

# RUN apt-get update && \
#     apt-get -y install \
#         apt-transport-https ca-certificates \
#     && \
#     printf "%s\n%s\n%s\n%s\n" > /etc/apt/sources.list \
#         'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse' \
#         'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse' \
#         'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse' \
#         'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse'

RUN apt-get update && \
    apt-get -y install \
        apt-transport-https ca-certificates \
        curl unzip gnupg lsb-release \
        vim bash-completion sudo openssh-server \
        python3 python3-pip \
        openjdk-8-jdk \
        subversion git \
        docker.io

COPY init.sh /root/
RUN cd /root && bash init.sh && rm init.sh

# defects4j dependencies
RUN apt-get update && apt-get -y install cpanminus && \
    cd /tmp && git clone https://github.com/rjust/defects4j.git && \
    cd defects4j && cpanm --installdeps . && cd / && rm -rf /tmp/defects4j

RUN apt-get update && apt-get -y install \
        maven

# BugSwarm
RUN pip3 install bugswarm-client

RUN sudo su thebesttv -c "cd ~/ && \
    git clone https://github.com/ucd-plse/Static-Bug-Detectors-ASE-Artifact.git && \
    cd Static-Bug-Detectors-ASE-Artifact && \
    bash analyzers/init_env.sh |& tee ~/log-init_env"

COPY login.sh /root/
ENTRYPOINT cd /root && bash login.sh && bash
