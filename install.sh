#!/bin/bash

cd .. #fix directory to be outside simulator
mkdir simulator_server
cp -r simulator simulator_server
cd simulator_server

#Install all the prerequisit software
echo
echo Install all the prerequisit software...
echo

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install nodejs -y
sudo apt-get install doxygen -y
sudo apt-get install npm -y
sudo apt-get install node -y
sudo npm install --global npm
sudo npm install --global yarn
yarn --version


#Just in case, install cmake and make...
echo
echo Just in case, install cmake and make...
echo

sudo apt-get install cmake
sudo apt-get install build-essential


#Install emscripten
echo
echo Install emscripten..
echo

git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
./emsdk install latest
./emsdk activate latest
cd ..


#Download and install simulator
echo
echo Download and install simulator
echo

git clone https://github.com/kipr/simulator.git
cd simulator
yarn install
cd ..


#Install libwallaby (emscripten version)
echo
echo "Install libwallaby (emscripten version)"
echo

git clone --branch emscripten https://github.com/kipr/libwallaby.git
mkdir libwallaby/build

#Fix directory and add emsdk_env.sh to $PATH temporarily
echo
echo "Fix directory and add emsdk_env.sh to PATH temporarily"
echo

cd emsdk
source emsdk_env.sh
cd ..


#Build Libwallaby (with emscripten)
echo
echo "Build Libwallaby (with emscripten)"
echo

cd libwallaby/build
emcmake cmake -Dwith_vision_support=OFF -Dwith_graphics_support=OFF -Dno_wallaby=ON -Dbuild_python=OFF .. -DJS_ONLY=ON
emmake make -j8
cd ../..


#Run the Server in parralel
sudo chmod 777 simulator/runServer.sh
cd simulator
sudo ./runServer.sh &
cd ..

#Build Simulator in watch mode and run in background
echo
echo Build Simulator in watch mode and run in background
echo

cd simulator
yarn watch


