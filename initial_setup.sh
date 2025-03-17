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
mkdir $INSTALL_DIR
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
sudo apt-get install git build-essential wget gpg curl pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev -y

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
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release 
make
sudo make install

echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
echo -e "$COLOR_GREEN |    INSTALL 11/15    | $COLOR_END"
echo -e "$COLOR_GREEN |         Qt5         | $COLOR_END"
echo -e "$COLOR_GREEN ----------------------- $COLOR_END"
sudo apt install -y qtcreator qtbase5-dev qt5-qmake cmake libqt5gamepad5-dev

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
cmake .. -DCMAKE_INSTALL_PREFIX=$RAI_INSTALL_DIR -DRAISIM_EXAMPLE=OFF
make install -j4
sudo apt-get install minizip ffmpeg -y
sudo apt-get install vulkan-utils -y
sudo ln -s /usr/lib/x86_64-linux-gnu/libdl.so.2 /usr/lib/x86_64-linux-gnu/libdl.so

echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALL_DIR/raisimLib/raisim/linux/lib" >> ~/.bashrc
echo "export PYTHONPATH=$PYTHONPATH:$INSTALL_DIR/raisimLib/raisim/linux/lib" >> ~/.bashrc
echo " --------------------------------------------------------------------------------------------------- "
echo " |     For link raisim, cmake option : -DCMAKE_PREFIX_PATH=$INSTALL_DIR/raisimLib/raisim/linux     | "
echo " --------------------------------------------------------------------------------------------------- "

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

sudo apt install -y software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt upgrade
sudo apt install ros-humble-desktop -y
sudo apt install ros-dev-tools -y


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

source ~/.bashrc

cd $CURRENT_DIR
cd ..
sudo rm -rf ubuntu-initial-setup
timedatectl set-local-rtc 1 --adjust-system-clock

echo -e "$COLOR_RED NEED TO REBOOT ! $COLOR_END"
echo -e "$COLOR_RED NEED TO REBOOT ! $COLOR_END"
echo -e "$COLOR_RED NEED TO REBOOT ! $COLOR_END"
echo -e "$COLOR_RED NEED TO REBOOT ! $COLOR_END"
echo -e "$COLOR_RED NEED TO REBOOT ! $COLOR_END"
