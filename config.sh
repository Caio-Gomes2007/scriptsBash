#!/bin/bash

programasInstalar=(

discord
openssh
nvim
virtual-box

)
sudo pacman Syu --noconfirm

for programa in "${programasInstalar[@]}"; do
    sudo pacman -S --noconfirm $programa
done

mkdir ~/Github
cd Github
##clonando os repostios mais importantes

echo "Clonagem de repositorios"
declare -a repo
repo[0]="git@github.com:Caio-Gomes2007/LinuxConfigArch.git"
repo[1]="git@github.com:Caio-Gomes2007/estudos-home.git"
repo[2]="git@github.com:Caio-Gomes2007/projetos.git"

for i in "${repo[@]}"; do
    git clone "$i"
done
cd

##Colocando o tema do bspwm
#echo "Coloando o tema do bspwm"

#curl -L https://is.gd/gh0stzk_dotfiles -o $HOME/RiceInstaller
#chmod +x RiceInstaller
#./RiceInstaller
reboot
