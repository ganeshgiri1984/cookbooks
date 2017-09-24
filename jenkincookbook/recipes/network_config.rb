#
# Cookbook Name:: jenkincookbook
# Recipe:: default
#
# Copyright 2017, GANESHTECH PVT. LTD.
#
# All rights reserved - Do Not Redistribute
#
#*************************************************************************************************#
#Date:		17-Sep-2017                                                                       #
#Auther:	Ganesh kinkar Giri                                                                #
#Purpose:	This recipe will set host,network,selinux,iptables,Apache tomcat and jenkins      #
#Os suport:	Centos 6.8 & Ubuntu 14.4                                                          #
#*************************************************************************************************#	
bash 'host file update'	do
	code <<-EOF
	platform=#{node['platform']}
	if [ "$platform" == "centos" ]
	then
		NODE_IP=#{node['ipaddress']}
		chkipconfig=`grep #{node['ipaddress']} /etc/hosts|wc -l`
	if [ "$chkipconfig" -ge "1" ]
        then
		echo "Ip is already configured"
	else
		echo $NODE_IP"	#{node['jenkincookbook']['HOSTNAME']}	#{node['jenkincookbook']['HOSTNAME_DESC']}" >> /etc/hosts
        fi
	elif [ "$platform" == "ubuntu" ]
		then
		NODE_IP=#{node['ipaddress']}
        	chkipconfig=`grep #{node['ipaddress']} /etc/hosts|wc -l`
        if [ "$chkipconfig" -ge "1" ]
        	then
        	echo "Ip is already configured"
        else
		echo $NODE_IP"  #{node['jenkincookbook']['HOSTNAME']}       #{node['jenkincookbook']['HOSTNAME_DESC']}" >> /etc/hosts
	fi
        fi
	EOF
end

bash 'network file update' do
        code <<-EOF
        platform=#{node['platform']}
        if [ "$platform" == "centos" ]
        then
        echo "NETWORKING=yes" > /etc/sysconfig/network
        echo "HOSTNAME=#{node['jenkincookbook']['HOSTNAME']}" >> /etc/sysconfig/network
        elif [ "$platform" == "ubuntu" ]
	then
	sed  '/127.0.1.1/d' /etc/hosts > /etc/hosts
        echo "127.0.1.1        #{node['jenkincookbook']['HOSTNAME']}" >> /etc/hosts
        fi
        EOF
end

cookbook_file '/etc/selinux/config' do
        source  'config'
end

bash 'iptables' do
        code <<-EOF
        iptables -F
        chkconfig iptables off
	reboot
        EOF
	ignore_failure true
	not_if do ::File.exists?('/tmp/reboot.lock') end
	not_if 'ls -lrth /tmp/reboot.lock'
end

bash 'chekconfig' do
	code <<-EOF
	sestatus
	cat /etc/hosts
	cat /etc/sysconfig/network
	cat /etc/selinux/config
	EOF
end
