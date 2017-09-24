#
# Cookbook Name:: jenkincookbook
# Recipe:: jenkins_installation
#
# Copyright 2017, GANESHTECH PVT. LTD.
#
# All rights reserved - Do Not Redistribute
#
#*************************************************************************************************#
#Date:		19-Sep-2017                                                                       #
#Auther:	Ganesh kinkar Giri                                                                #
#Purpose:	This recipe will install tomcat and do setup                                      #
#Os suport:	Centos 6.8 & Ubuntu 14.4                                                          #
#*************************************************************************************************#
bash 'jenkins war file download to tomcat webapp' do
	code <<-EOF
	cd #{node['jenkincookbook']['tomcat_webapps_path']}
	wget #{node['jenkincookbook']['jenkins_war_file_url']}
	EOF
end
