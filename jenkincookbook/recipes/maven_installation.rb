#
# Cookbook Name:: jenkincookbook
# Recipe:: maven_installation
#
# Copyright 2017, GANESHTECH PVT. LTD.
#
# All rights reserved - Do Not Redistribute
#
#*************************************************************************************************#
#Date:		17-Sep-2017                                                                       #
#Auther:	Ganesh kinkar Giri                                                                #
#Purpose:	This recipe will install maven and do setup                                       #
#Os suport:	Centos 6.8 & Ubuntu 14.4                                                          #
#*************************************************************************************************#
bash 'Apache Maven instalation' do
	code <<-EOF
	cd #{node['jenkincookbook']['MAVEN_FILE_PATH']}
	wget #{node['jenkincookbook']['MAVEN_FILE_URL']}
	tar xzf #{node['jenkincookbook']['MAVEN_TAR_FILE']}
	cd #{node['jenkincookbook']['MAVEN_PATH']}
	EOF
end

bash 'bashrc configuration' do
        code <<-EOF
        M2_HOME_CHK=`grep #{node['jenkincookbook']['M2_HOME']} /etc/bashrc|wc -l`
        if [ "$M2_HOME_CHK" -ge "1" ]
        then
        echo "MAVEN PATH is already present in /etc/bashrc"
        else
        echo "export M2_HOME=#{node['jenkincookbook']['M2_HOME']}" >> /etc/bashrc
        fi
	PATH_CHK=`grep #{node['jenkincookbook']['MAVEN_BIN_PATH']} /etc/bashrc|wc -l`
        if [ "$PATH_CHK" -ge "1" ]
        then
        echo "MAVEN PATH is already present in /etc/bashrc"
        else
        echo "export PATH=#{node['jenkincookbook']['MAVEN_BIN_PATH']}" >> /etc/bashrc
        fi
        EOF
end

bash 'reload bashrc file' do
        code <<-EOF
        source /etc/bashrc
	mvn --version
        EOF
end
