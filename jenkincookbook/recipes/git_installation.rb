#
# Cookbook Name:: jenkincookbook
# Recipe:: git_installation
#
# Copyright 2017, GANESHTECH PVT. LTD.
#
# All rights reserved - Do Not Redistribute
#
#*************************************************************************************************#
#Date:		17-Sep-2017                                                                       #
#Auther:	Ganesh kinkar Giri                                                                #
#Purpose:	This recipe will install git and do setup                                         #
#Os suport:	Centos 6.8 & Ubuntu 14.4                                                          #
#*************************************************************************************************#
package %w(curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc perl-ExtUtils-MakeMaker) do
	action	:install
end

bash 'git' do
	code <<-EOF
	cd #{node['jenkincookbook']['GIT_FILE_DIR']}
	wget #{node['jenkincookbook']['GIT_URL']}
	tar xzf #{node['jenkincookbook']['GIT_TAR_FILE']}
	cd #{node['jenkincookbook']['GIT_PATH']}
	make prefix=/usr/local/git all
	make prefix=/usr/local/git install
	EOF
end

bash 'bashrc configuration' do
        code <<-EOF
        PATH_CHK=`grep #{node['jenkincookbook']['GIT_BIN_PATH']} /etc/bashrc|wc -l`
        if [ "$PATH_CHK" -ge "1" ]
        then
        echo "GIT PATH is already present in /etc/bashrc"
        else
        echo "export PATH=#{node['jenkincookbook']['GIT_BIN_PATH']}" >> /etc/bashrc
        fi
        EOF
end

bash 'reload bashrc file' do
        code <<-EOF
        source /etc/bashrc
	git --version
        EOF
end
