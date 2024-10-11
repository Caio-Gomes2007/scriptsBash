#!/bin/bash
#basicamente o script so liga o tlp que faz a magica toda

echo "costuma demorar um pouco por favor espere"
sudo systemctl start tlp
systemctl status tlp

