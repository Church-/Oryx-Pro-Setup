#!/bin/bash

install_via_apt() 
{
	#prereqs
	sudo apt update && apt -y install apt-transport-https ca-certificates curl software-properties-common gdebi-core wget
	#mopidy
	wget -q -O - https://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
	sudo wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/stretch.list
	#firefos
	sudo add-apt-repository ppa:mozillateam/firefox-next
	#docker
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	#kubectl
	sudo apt-get update && sudo apt-get install -y apt-transport-https
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	sudo touch /etc/apt/sources.list.d/kubernetes.list
	echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	#steam
	sudo add-apt-repository multiverse
	#Weechat
	sudo sh echo -c "deb https://weechat.org/ubuntu bionic main"  >> /etc/apt/sources.list.d/weechat.list
	sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E
	#retroarch emu system
	sudo add-apt-repository ppa:libretro/stable
	#PCXS2 - PS2 Emulator
	sudo add-apt-repository ppa:gregory-hainaut/pcsx2.official.ppa
	#Dolphin - Gamecube/Wii emu
	sudo apt-add-repository ppa:dolphin-emu/ppa
	#PPSSPP - PSP emu
	sudo add-apt-repository ppa:ppsspp/stable
	#System 76 PPA
	sudo apt-add-repository -y ppa:system76-dev/stable
	#Update and install
	sudo apt update && sudo apt upgrade
	sudo apt -y install ranger mpd firefox kubectl dnsutils python-pip \
	steam git rsync feh neofetch jq borgbackup nmtui tmux kdeconnect fbreader pastebinit fzf \
	zsh ncmpcpp neomutt urlview newsbeuter mpv rtorrent transmission-gtk weechat rofi mopidy \
	system76-cuda-latest system76-cudnn-9.2 system76-driver system76-driver-nvidia thermald \
	retroarch libretro-* pcsx2 dolphin-emu ppsspp
}

setup_fans_and_thermals() 
{
	pmwconfig
	 	
}

install_pcs3() 
{
	# RPCS3 - PS3 emu
	sudo wget -O /usr/local/bin/pcs3 --content-disposition https://rpcs3.net/latest-appimage
	chmod a+x /usr/local/bin/pcs3
}

install_python_packages_via_pip() 
{
	pip install FoxDot soundscrape youtuhe-dl mopidy-gmusic Mopidy-Podcast Mopidy-Podcast-gpodder.net
}

add_user_to_docker_group() 
{
	export name=$(whoami)
	sudo usermod -aG docker $name
}

install_rust() 
{
	#rust lang
	curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable
}

install_from_github() 
{
	#micro editor
	curl https://getmic.ro | bash
	sudo mv ./micro /usr/local/bin/
	
	#kops
	curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
	chmod +x kops-linux-amd64
	sudo mv kops-linux-amd64 /usr/local/bin/kops
	
	#dosage
	git clone https://github.com/webcomics/dosage && sudo pip install -r dosage/requirements.txt && sudo python dosage/setup.py install
	
	#ripgrep
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.9.0/ripgrep_0.9.0_amd64.deb
	sudo dpkg -i ripgrep_0.9.0_amd64.deb
	#fd
	curl -LO https://github.com/sharkdp/fd/releases/download/v7.1.0/fd_7.1.0_amd64.deb
	sudo dpkg -i fd_7.1.0_amd64.deb
	#discord
	wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
	dpkg -i ~/discord.deb --force-confnew

	#polybar

	#i3-gaps

	#clean up
	rm -rf ~/*.deb
	rm -rf ~/dosage/
	
}

install_pentest_tools() 
{
	#Kali Tools
	git clone https://github.com/LionSec/katoolin.git  && sudo cp katoolin/katoolin.py /usr/bin/katoolin
	sudo chmod +x /usr/local/bin/katoolin
	katoolin
}

install_via_apt
add_user_to_docker_group
setup_fans_and_thermals
install_rust
install_from_github
install_python_packages_via_pip
install_from_github
install_pcs3
install_pentest_tools