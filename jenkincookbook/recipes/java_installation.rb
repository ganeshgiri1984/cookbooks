#
# Cookbook Name:: jenkincookbook
# Recipe:: java_installation
#
# Copyright 2017, GANESHTECH PVT. LTD.
#
# All rights reserved - Do Not Redistribute
#
#*************************************************************************************************#
#Date:		17-Sep-2017                                                                       #
#Auther:	Ganesh kinkar Giri                                                                #
#Purpose:	This recipe will install Java                                                     #
#Os suport:	Centos 6.8 & Ubuntu 14.4                                                          #
#*************************************************************************************************#	
bash 'java rpm download' do
	code <<-EOF
	cd /opt
	wget #{node['jenkincookbook']['JAVA_FILE_URL']}
	tar zxf #{node['jenkincookbook']['JAVA_TAR_FILE']}
	EOF
end

bash 'bashrc configuration' do
	code <<-EOF
	JAVA_HOME=`grep #{node['jenkincookbook']['JAVA_HOME']} /etc/bashrc|wc -l`
	if [ "$JAVA_HOME" -ge "1" ]
	then
	echo "JAVA_HOME path already present in /etc/bashrc"
	else
	echo "export JAVA_HOME=#{node['jenkincookbook']['JAVA_HOME']}" >> /etc/bashrc
	fi
	JRE_HOME=`grep #{node['jenkincookbook']['JRE_HOME']} /etc/bashrc|wc -l`
	if [ "$JRE_HOME" -ge "1" ]
	then
	echo "JRE_HOME path already present in /etc/bashrc"
	else
	echo "export JRE_HOME=#{node['jenkincookbook']['JRE_HOME']}" >> /etc/bashrc
        fi
	PATH_CHK=`grep #{node['jenkincookbook']['PATH']} /etc/bashrc|wc -l`
	if [ "$PATH_CHK" -ge "1" ]
	then
	echo "PATH is already present in /etc/bashrc"
	else
	echo "export PATH=#{node['jenkincookbook']['PATH']}" >> /etc/bashrc
	fi
	EOF
end

bash 'reload bashrc file' do
	code <<-EOF
	source /etc/bashrc
	EOF
end
