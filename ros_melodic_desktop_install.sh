#!/bin/bash

###### DRC LAB. 2018. 11. 1. CDI ######
###### Install ros-melodic-desktop at ubuntu, ubuntu mate ######

# Add ROS repo to apt list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

# Update Debian package
sudo apt-get update
sudo apt-get upgrade -y

# Install Bootstrap Dependencies
sudo apt-get install ros-melodic-desktop-full ros-melodic-joystick-drivers 

# Install rosdep (package manager)
sudo rosdep init
rosdep update

# Add setup.bash at .bashrc
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
