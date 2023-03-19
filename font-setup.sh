#!/bin/bash

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip -P /tmp/
unzip /tmp/JetBrainsMono.zip -d /tmp/font-temp

echo "Cleaning up"
rm /tmp/JetBrains*
rm -rf /tmp/font-temp
