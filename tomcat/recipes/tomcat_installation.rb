#
# Cookbook Name:: jenkincookbook
# Recipe:: tomcat_installation
#
# Copyright 2017, GANESHTECH PVT. LTD.
#
# All rights reserved - Do Not Redistribute
#
#*************************************************************************************************#
#Date:		17-Sep-2017                                                                       #
#Auther:	Ganesh kinkar Giri                                                                #
#Purpose:	This recipe will install tomcat and do setup                                      #
#Os suport:	Centos 6.8 & Ubuntu 14.4                                                          #
#*************************************************************************************************#
bash 'Apache Maven instalation' do
	code <<-EOF
	cd #{node['jenkincookbook']['TOMCAT_FILE_PATH']}
	wget #{node['jenkincookbook']['TOMCAT_FILE_URL']}
	tar xzf #{node['jenkincookbook']['TOMCAT_TAR_FILE']}
	mv #{node['jenkincookbook']['TOMCAT_PATH']} tomcat
	rm -rf #{node['jenkincookbook']['TOMCAT_PATH']}
	rm -rf #{node['jenkincookbook']['TOMCAT_TAR_FILE']}
	cd #{node['jenkincookbook']['TOMCAT_CONF_PATH']}
	cp -p tomcat-users.xml tomcat-users.xml.original
	EOF
end

template 'tomcat-users.xml' do
	path '/opt/tomcat/conf/tomcat-users.xml' 
	source 'tomcat-users.erb'
end

template 'context.xml' do
        path '/opt/tomcat/webapps/manager/META-INF/context.xml'
        source 'context.erb'
end

bash 'start tomcat' do
	code <<-EOF
	cd #{node['jenkincookbook']['TOMCAT_BIN_PATH']}
	./startup.sh
	EOF
end
