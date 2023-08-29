FROM debian:latest

# Create data folder for the Satisfactory Dedicated Server
# TODO
# RUN mkdir /data
# VOLUME ["/data"]

# Set up apt
# Update the package cache
RUN apt update

# Install sudo
RUN apt install sudo -y

# Install SteamCMD and create Steam user
# Taken from https://developer.valvesoftware.com/wiki/SteamCMD#Linux

# Create Steam user
RUN sudo useradd -m steam
RUN usermod --password steam steam
# Add steam user to sudoers file
RUN sudo adduser steam sudo

RUN sudo -u steam -s
RUN cd /home/steam
RUN sudo apt update

# Update /etc/apt/sources.list
RUN echo "deb http://deb.debian.org/debian bullseye main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian bullseye main contrib non-free" >> /etc/apt/sources.list

RUN echo "deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free" >> /etc/apt/sources.list

RUN echo "deb http://deb.debian.org/debian bullseye-updates main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free" >> /etc/apt/sources.list

RUN sudo apt update

# Install SteamCMD packages and dependencies
RUN sudo apt-get install software-properties-common -y
RUN sudo dpkg --add-architecture i386
RUN sudo apt update
RUN echo steam steam/question select "I AGREE" | sudo debconf-set-selections && sudo apt install steamcmd -y

# Export CPU_MHZ, required for SteamCMD to run on Oracle VMs
RUN export CPU_MHZ=3000

# Run SteamCMD and install the Satisfactory Dedicated Server
RUN /usr/games/steamcmd +@sSteamCmdForcePlatformBitness 64 +force_install_dir ~/SatisfactoryDedicatedServer +login anonymous +app_update 1690800 -beta experimental validate +quit

# Change permissions for the Satisfactory Dedicated Server folder, so the Satisfactory Dedicated Server can access it properly
RUN sudo chmod -R 777 ~/SatisfactoryDedicatedServer

# Start the Satisfactory Dedicated Server
RUN cd ~/SatisfactoryDedicatedServer/
RUN ./FactoryServer.sh -log




# Here's DJMalachite's guide since the dockerfile will probably fail at the end and require manual setup
# Satis on oracle ALWAYS FREE ARM VM

# Create Arm server with 4 OCPUs and 24gb of ram and select the Ubuntu Arch64 image

# In the VCS settings open the ports for satis

# Once you have gained SSH access
# Install docker and run  "docker run --privileged --rm tonistiigi/binfmt --install amd64" to set up emulation

# Then run export DOCKER_DEFAULT_PLATFORM=linux/amd64 to force amd64 as the default docker platform

# Then do docker run -it  --name debian-satisfactory-server -p 7777:7777 -p 15000:15000 -p 15777:15777 debian:latest 
# This gets you a docker container running debian on an emulated x86_64 cpu and open ports

# attach shell to the debian container
# Install SteamCMD follow (https://developer.valvesoftware.com/wiki/SteamCMD#Linux)
# run export CPU_MHZ=2500 fixes SteamCMD
# Download Satisfactory using the command "/usr/games/steamcmd +@sSteamCmdForcePlatformBitness 64 +force_install_dir ~/SatisfactoryDedicatedServer +login anonymous +app_update 1690800 -beta experimental validate +quit"
# sudo chmod -R 777 "YOUR SATISFACTORY SERVER FOLDER"

# Run server
# Profit
