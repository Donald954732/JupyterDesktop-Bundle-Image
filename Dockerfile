# R and scientific python 
FROM jupyter/datascience-notebook:latest

USER root

RUN apt-get -y update \
 && apt-get install -y dbus-x11 \
   firefox \
   xfce4 \
   xfce4-panel \
   xfce4-session \
   xfce4-settings \
   xorg \
   xubuntu-icon-theme 
# JDK and JRE
RUN apt-get install -y default-jre \
   default-jdk 
#C and C++
RUN apt-get install -y gcc \
   g++ \
   build-essential

#Fortran
RUN apt-get install -y gfortran 

#Atom
RUN apt install -y software-properties-common apt-transport-https wget \
   && wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add - \
   && add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" \
   && apt install -y atom

#vscode
RUN apt-get -y update && \
   apt-get install -y software-properties-common \
   apt-transport-https \
   wget \ 
&& wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add - \
&& add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" \
&& apt install -y code

#Lyx
RUN add-apt-repository ppa:lyx-devel/release && \
   apt-get update -y && \
   apt-get install -y lyx

#LibreOffice
RUN apt install -y libreoffice

#VLC
RUN apt install -y vlc


# Remove light-locker to prevent screen lock
ARG TURBOVNC_VERSION=2.2.6
RUN wget -q "https://sourceforge.net/projects/turbovnc/files/${TURBOVNC_VERSION}/turbovnc_${TURBOVNC_VERSION}_amd64.deb/download" -O turbovnc_${TURBOVNC_VERSION}_amd64.deb && \
   apt-get install -y -q ./turbovnc_${TURBOVNC_VERSION}_amd64.deb && \
   apt-get remove -y -q light-locker && \
   rm ./turbovnc_${TURBOVNC_VERSION}_amd64.deb && \
   ln -s /opt/TurboVNC/bin/* /usr/local/bin/

# apt-get may result in root-owned directories/files under $HOME
RUN chown -R $NB_UID:$NB_GID $HOME

ADD . /opt/install
RUN fix-permissions /opt/install

USER $NB_USER
RUN cd /opt/install && \
   conda env update -n base --file environment.yml
