#!/bin/bash

HOME_DIR=/home/$USER/
CURRENT_DIR=$(pwd)

# red color
COLOR_RED="\033[1;31m"
COLOR_GREEN="\033[1;32m"
COLOR_END="\033[0m"

echo
echo
echo
echo -e "$COLOR_RED ------------------------------------------------------------------------ $COLOR_END"
echo -e "$COLOR_RED |                  | Type package install directory |                  | $COLOR_END"
echo -e "$COLOR_RED ------------------------------------------------------------------------ $COLOR_END"
echo " ex) /home/ys or /home/ys/Library ..."
read INSTALL_DIR
echo "Check install directory : $INSTALL_DIR"
echo "."
echo "."
echo -e "$COLOR_RED ------------------------------------------------------------------------- $COLOR_END"
echo -e "$COLOR_RED |                   | Type Raisim install directory |                   | $COLOR_END"
echo -e "$COLOR_RED ------------------------------------------------------------------------- $COLOR_END"
echo "ex) /home/ys/raisimLib/install or /home/ys/Library/raisimLib/build/install"
read RAI_INSTALL_DIR
echo "Check Raisim install directory : $RAI_INSTALL_DIR"
echo "."
echo "."
echo "Load gpu drivers..."

echo -e "$COLOR_RED ------------------------------------------------------------------------- $COLOR_END"
echo -e "$COLOR_RED |                   | Type Camel tools installed directory |                   | $COLOR_END"
echo -e "$COLOR_RED ------------------------------------------------------------------------- $COLOR_END"
echo "ex) /home/ys/Library/camel-tools"
read CTOOL_INSTALL_DIR
echo "Check camel-tools install directory : $CTOOL_INSTALL_DIR"
echo "."
echo "."
echo "Load gpu drivers..."
ubuntu-drivers devices
echo -e "$COLOR_RED ----------------------------------------------------------------------- $COLOR_END"
echo -e "$COLOR_RED |                   | Type recommended GPU driver |                   | $COLOR_END"
echo -e "$COLOR_RED ----------------------------------------------------------------------- $COLOR_END"
echo -e " ex) nvidia-driver-470  $COLOR_RED ( BEFORE - distro ... )  $COLOR_END"
echo -e " PLEASE JUST ENTER and SKIP, if you don't have external graphic card."
read GPU_DRIVER
echo "Check gpu driver : $GPU_DRIVER"
echo "."
echo "."
echo "."
echo "."
echo -e "$COLOR_GREEN --------------------- $COLOR_END"
echo -e "$COLOR_GREEN |   INSTALL 00/15   | $COLOR_END"
echo -e "$COLOR_GREEN |  start installing | $COLOR_END"
echo -e "$COLOR_GREEN --------------------- $COLOR_END"

sudo apt-get update -y
sudo apt-get upgrade -y

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 01/15    | $COLOR_END"
echo -e "$COLOR_GREEN |      Essential      | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
sudo apt-get install build-essential wget gpg curl pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev -y

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 02/15    | $COLOR_END"
echo -e "$COLOR_GREEN |        Cmake        | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
cd $INSTALL_DIR
sudo apt-get install libssl-dev -y
wget https://github.com/Kitware/CMake/releases/download/v3.21.0/cmake-3.21.0.tar.gz
tar -xvf cmake-3.21.0.tar.gz
cd cmake-3.21.0
./bootstrap && make && sudo make install
cd .. && sudo rm -rf cmake-3.21.0 && sudo rm -rf cmake-3.21.0.tar.gz

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 03/15    | $COLOR_END"
echo -e "$COLOR_GREEN |        CLion        | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
sudo snap install clion --classic

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 04/15    | $COLOR_END"
echo -e "$COLOR_GREEN |        Slack        | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
sudo snap install slack --classic

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 05/15    | $COLOR_END"
echo -e "$COLOR_GREEN |        notion       | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
sudo snap install notion-snap-reborn --classic

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 06/15    | $COLOR_END"
echo -e "$COLOR_GREEN |       Python3       | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
sudo apt-get install python3 python3-pip -y

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 07/15    | $COLOR_END"
echo -e "$COLOR_GREEN |      terminator     | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
sudo apt-get install terminator -y

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 8/15     | $COLOR_END"
echo -e "$COLOR_GREEN | simplescreenrecorder| $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
sudo apt-get install simplescreenrecorder -y

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 9/15     | $COLOR_END"
echo -e "$COLOR_GREEN |        Eigen        | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
sudo apt-get install libeigen3-dev

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 10/15    | $COLOR_END"
echo -e "$COLOR_GREEN |         RBDL        | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
cd $INSTALL_DIR
sudo apt-get install libboost-all-dev -y
git clone https://github.com/rbdl/rbdl.git
cd rbdl
git submodule init
git submodule update
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DRBDL_BUILD_ADDON_URDFREADER=ON
make
sudo make install

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 11/15    | $COLOR_END"
echo -e "$COLOR_GREEN |         Qt5         | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
sudo apt-get install qtcreator -y
sudo apt-get install qt5-default -y

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 12/15    | $COLOR_END"
echo -e "$COLOR_GREEN |        Raisim       | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
cd $INSTALL_DIR
git clone https://github.com/raisimTech/raisimLib.git
cd raisimLib
mkdir build
mkdir install
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$RAI_INSTALL_DIR -DRAISIM_EXAMPLE=ON
make install -j4
sudo apt-get install minizip ffmpeg -y
sudo apt-get install vulkan-utils -y
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALL_DIR/raisimLib/raisim/linux/lib" >> ~/.bashrc
echo "export PYTHONPATH=$PYTHONPATH:$INSTALL_DIR/raisimLib/raisim/linux/lib" >> ~/.bashrc
echo " --------------------------------------------------------------------------------------------------- "
echo " |     For link raisim, cmake option : -DCMAKE_PREFIX_PATH=$INSTALL_DIR/raisimLib/raisim/linux     | "
echo " --------------------------------------------------------------------------------------------------- "
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 13/15    | $COLOR_END"
echo -e "$COLOR_GREEN |        ROS          | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"

cd

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

sudo apt update && sudo apt install curl gnupg2 lsb-release -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg

sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654
sudo apt update

sudo apt install ros-foxy-desktop -y

sudo apt install -y python3-pip
pip3 install -U argcomplete

sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt update

sudo apt install gazebo11 libgazebo11-dev -y

sudo apt install ros-foxy-gazebo-ros-pkgs -y

sudo apt install ros-foxy-rqt* -y
sudo apt install ros-foxy-image-view -y
sudo apt install ros-foxy-navigation2 ros-foxy-nav2-bringup -y
sudo apt install ros-foxy-joint-state-publisher-gui -y
sudo apt install ros-foxy-xacro -y
sudo apt update
sudo apt install python3-colcon-common-extensions -y

echo
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 14/15    | $COLOR_END"
echo -e "$COLOR_GREEN |     camel-tools     | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
cd $CTOOL_INSTALL_DIR
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade
sudo update-grub
sudo chmod +x tools_install.sh
./tools_install.sh -a

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 15/15    | $COLOR_END"
echo -e "$COLOR_GREEN |       qpOASES       | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
cd $INSTALL_DIR

git clone https://github.com/coin-or/qpOASES.git
cd qpOASES
mkdir build
cd build
cmake ..
make
sudo make install

echo
echo -e "$COLOR_GREEN --------------------- $COLOR_END"
echo -e "$COLOR_GREEN |   INSTALL 15/15   | $COLOR_END"
echo -e "$COLOR_GREEN |     installed     | $COLOR_END"
echo -e "$COLOR_GREEN --------------------- $COLOR_END"

echo -e "$COLOR_GREEN -------------- $COLOR_END"
echo -e "$COLOR_GREEN | setup bash | $COLOR_END"
echo -e "$COLOR_GREEN -------------- $COLOR_END"

echo "alias gb='gedit ~/.bashrc'" >> ~/.bashrc
echo "alias sb='source ~/.bashrc'" >> ~/.bashrc
echo "alias cb='colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=1'" >> ~/.bashrc
echo "alias rosfoxy='source /opt/ros/foxy/setup.bash && source ~/gcamp_ros2_ws/install/local_setup.bash'" >> ~/.bashrc
echo "alias rosadd='. install/setup.bash'" >> ~/.bashrc
echo "alias simgl='cd /home/ys/Library/raisimLib/raisimUnityOpengl/linux/ && ./raisimUnity.x86_64'" >> ~/.bashrc
echo "alias simuni='cd /home/ys/Library/raisimLib/raisimUnity/linux/ && ./raisimUnity.x86_64'" >> ~/.bashrc

source ~/.bashrc

cd $CURRENT_DIR
cd ..
sudo rm -rf ubuntu-initial-setup

echo -e "$COLOR_RED NEED TO REBOOT ! $COLOR_END"
echo -e "$COLOR_RED NEED TO REBOOT ! $COLOR_END"
echo -e "$COLOR_RED NEED TO REBOOT ! $COLOR_END"
echo -e "$COLOR_RED NEED TO REBOOT ! $COLOR_END"
echo -e "$COLOR_RED NEED TO REBOOT ! $COLOR_END"
