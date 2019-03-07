FROM centos:latest

RUN yum update -y \
    && yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
    && yum install -y wget which

# install qt
# RUN yum install -y http://mirror.centos.org/centos/7/os/x86_64/Packages/qt-4.8.7-2.el7.x86_64.rpm \
    # && yum install -y qtcreator \
    # libqtxdg
RUN yum install -y libxkbcommon libxkbcommon-devel libxkbcommon-x11 libxkbcommon-x11-devel \
    && yum install -y libqtxdg libqtxdg-devel freeglut freeglut-devel \
    && yum install -y mesa-libGL mesa-libGL-devel mesa-libEGL mesa-libGLU\
    && yum install -y qt5-qtbase qt5-qtbase-devel qtcreator

# make a new user
RUN mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    chown developer:developer -R /home/developer

USER developer
ENV HOME /home/developer
WORKDIR /home/developer
CMD [ "qtcreator" ]