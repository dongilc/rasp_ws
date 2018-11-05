#!/bin/bash

###### DRC LAB. 2018. 11. 1. CDI ######
###### Ref. http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Kinetic%20on%20the%20Raspberry%20Pi
###### Install ros-kinetic-comm at raspbian stretch ######

# missing package, installing “dirmngr” for certificate management.
sudo apt-get install -y dirmngr

# Add ROS repo to apt list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

# Update Debian package
sudo apt-get update
sudo apt-get upgrade -y

# Install Bootstrap Dependencies
sudo apt-get install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential cmake 

# Install rosdep (package manager)
sudo rosdep init
rosdep update

# Create a catkin Workspace
ROS_WS_DIR="$HOME/ros_kinetic_comm_custom_build"
mkdir $ROS_WS_DIR
cd $ROS_WS_DIR

# Build packages and libraries
rosinstall_generator ros_comm joystick_drivers nodelet ackermann_msgs nav_msgs tf dynamic_reconfigure --rosdistro kinetic --deps --wet-only --tar > kinetic-ros_comm_custom-wet.rosinstall
wstool init -j8 src kinetic-ros_comm_custom-wet.rosinstall

# Resolving Dependencies with rosdep
rosdep install -y --from-paths src --ignore-src --rosdistro kinetic -r --os=debian:stretch

# Build ROS 
cd $ROS_WS_DIR
sudo mkdir -p /opt/ros/kinetic
sudo chown pi:pi /opt/ros/kinetic
./src/catkin/bin/catkin_make_isolated -j2 --install --install-space /opt/ros/kinetic -DCMAKE_BUILD_TYPE=Release

# Add setup.bash at .bashrc
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
