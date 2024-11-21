#!/bin/bash

set -e

echo -e "\e[94mRunning init.sh to execute all setup scripts...\e[39m"

echo -e "\e[94mCalling essentials.sh\e[39m"
./essentials.sh

echo -e "\e[94mCalling git.sh...\e[39m"
./git.sh

echo -e "\e[94mCalling zsh.sh...\e[39m"
./zsh.sh

echo -e "\e[94mCalling fonts.sh...\e[39m"
./fonts.sh

echo -e "\e[94mCalling langs.sh\e[39m"
./langs.sh

echo -e "\e[94mCalling docker.sh\e[39m"
./docker.sh

echo -e "\e[94mAll setup scripts executed successfully!\e[39m"
