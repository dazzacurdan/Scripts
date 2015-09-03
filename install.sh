#!/bin/bash

WINDOWS_SHARE_FOLDER=$HOME"/Share"
WIN_USER=""
WIN_PASS=""

DOWNLOAD_FOLDER="Download"

echo ""
echo ".:Set variables:."

if [ "$LANG" == "en_US.UTF-8" ]
	then
		DOWNLOAD_FOLDER="Downloads"
		echo ""
		echo "--> Download folder is: $DOWNLOAD_FOLDER"
fi
if [ "$LANG" == "it_IT.UTF-8" ]
	then
		DOWNLOAD_FOLDER="Scaricati"
		echo "--> Download folder is:$DOWNLOAD_FOLDER"
fi

echo ""
echo ".:Update:."
echo ""
	sudo yum update
echo ""
echo ".:Install compiler Suite:."
echo ""
	 sudo yum install dkms gcc
echo ""
echo ".:Install cross-compiler for ARM:."
echo ""
	sudo yum install binutils-arm-linux-gnu gcc-arm-linux-gnu
echo ""
echo ".:Install cross-compiler for WIN:."
echo ""
	sudo yum install mingw32-gcc-c++ mingw64-gcc-c++
echo ""
echo ".:Install Utility:."
echo ""
	sudo yum install htop wget meld tree cmake subversion eclipse-cdt astyle oprofile-devel valgrind-devel rapidsvn


""
echo ".:Install Eigen:."
echo ""
	sudo yum install eigen3-devel

echo ""
echo ".:Install OpenCV:."
echo ""
	sudo yum install opencv

echo ""
echo ".:Sublime:."
echo ""

if [ ! -d /opt/sublime_text_3 ] then
	read -p "Do you want to install Sublime3 [y|N]: " confirmation
	if [[ "$confirmation" == "y" || "$confirmation" == "Y"  ]]; then
		if [ ! -e $HOME/$DOWNLOAD_FOLDER/sublime_text_3_build_3059_x64.tar.bz2 ]
			then
				wget http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3059_x64.tar.bz2 --directory-prefix=$HOME/$DOWNLOAD_FOLDER
		fi
		ACT_DIR=$(pwd)
		cd $HOME/$DOWNLOAD_FOLDER 
		if [ ! -e $HOME/$DOWNLOAD_FOLDER/sublime_text_3 ]
			then	
				tar xvf sublime_text_3_build_3059_x64.tar.bz2
		fi
		sudo mv sublime* /opt/
		#Shortcut
		if [ ! -e /usr/share/applications/sublime3.desktop ]
		then
			echo "--> Create Sublime Icon and Shortcut"
			echo "[Desktop Entry]" | sudo tee -a /usr/share/applications/sublime3.desktop
			echo "Version=3.0" | sudo tee -a /usr/share/applications/sublime3.desktop
			echo "Name=Sublime3" | sudo tee -a /usr/share/applications/sublime3.desktop
			echo "Comment=Sublime3" | sudo tee -a /usr/share/applications/sublime3.desktop
			echo "Comment[en]=Lightweight text editor" | sudo tee -a /usr/share/applications/sublime3.desktop
			echo "GenericName=Sublime Text3" | sudo tee -a /usr/share/applications/sublime3.desktop
			echo "Exec=/opt/sublime_text_3/sublime_text" | sudo tee -a /usr/share/applications/sublime3.desktop
			echo "Icon=/opt/sublime_text_3/Icon/256x256/sublime_text.png" | sudo tee -a /usr/share/applications/sublime3.desktop
			echo "StartupNotify=true" | sudo tee -a /usr/share/applications/sublime3.desktop
			echo "MimeType=text/x-utility;" | sudo tee -a /usr/share/applications/sublime3.desktop
			echo "Terminal=false" | sudo tee -a /usr/share/applications/sublime3.desktop
			echo "Type=Application" | sudo tee -a /usr/share/applications/sublime3.desktop
			echo "Categories=Programming;Other" | sudo tee -a /usr/share/applications/sublime3.desktop
		else
			echo ""
			echo "--> Sublime Icon and Shortcut already created"	
		fi
		#Install Package Control
		if [ ! -e /opt/sublime_text_3/Packages/Package%20Control.sublime-package ]
			then
				sudo wget https://sublime.wbond.net/Package%20Control.sublime-package --directory-prefix=/opt/sublime_text_3/Packages
				echo "--> Other packages are: Bash build system, Doxydoc, FileDiffs, Sublime clang, Sublimegdb, FileHeader"
		fi
	
		cd $ACT_DIR
	else
		echo "--> Sublime already installed"
		echo ""
	fi
fi

echo "" 
echo ".:Documentation:."
echo ""
	sudo yum install doxygen graphviz mscgen cppcheck

echo ""
echo ".:Mounting Points:."
echo ""
read -p "Do you want to edit /etc/fstab [y|N]: " confirmation
	if [[ "$confirmation" == "y" || "$confirmation" == "Y"  ]]; then
	read -p "Do you want to add $WINDOWS_SHARE_FOLDER [y|N]: " confirmation
	if [[ "$confirmation" == "y" || "$confirmation" == "Y"  ]]; then
		mkdir -p $WINDOWS_SHARE_FOLDER && echo "//path /home/user/Share cifs username=$WIN_USER,password=$WIN_PASS,uid=user,gid=user 0 0" | sudo tee -a /etc/fstab
	fi
	read -p "Mount new partitions now? [y|N]:" confirmation
	if [[ "$confirmation" == "y" || "$confirmation" == "Y"  ]]; then
		sudo mount -a
	fi
fi
