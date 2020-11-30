#!/bin/bash

function installDocker(){
 clear
 echo -e "\033[36;5m开始为您安装Docker...\033[0m" 
 sleep 3s
 clear
 echo -e "\033[32;43;2m【尝试为您卸载较旧的Docker版本称为docker或docker-engine...】\033[0m"
 sleep 1s
 (yum remove docker \
docker-client \
docker-client-latest \
docker-common \
docker-latest \
docker-latest-logrotate \
docker-logrotate \
docker-engine) 
  echo -e "\033[32;43;2m【正在为您安装yum-utils软件包...】\033[0m"
  sleep 1s
  (yum install -y yum-utils)
  echo -e "\033[32;43;2m【正在为您配置阿里云镜像仓库...】\033[0m"
  sleep 1s
  (yum-config-manager \
--add-repo \
https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo)
  echo -e "\033[32;43;2m【正在为您安装最新版本的Docker Engine和容器...】\033[0m"
  sleep 1s
  (yes y|yum install docker-ce docker-ce-cli containerd.io)
  clear
  echo -e "\033[32;43;2m【Dokcer安装完毕正在为您启动Docker】\033[0m"
  sleep 1s
  (systemctl start docker)
  sleep 1s
  echo -e "\033[32;1mDocker安装完毕！感谢您的使用(作者QQ：2966748189 博客：http://blog.sjviper.com)\033[0m"


}

function clearEnv(){
 echo -e "\033[35;5m正在卸载Docker Engine，CLI和Containerd软件包\033[0m" 
 (yes y|yum remove docker-ce docker-ce-cli containerd.io)
 echo -e "\033[35;5m正在删除相关Docker残留文件\033[0m" 
 (rm -rf /var/lib/docker)
}


function install(){
 clearEnv
 installDocker
}

function main(){
  clear
  echo -e "\033[43;37;1m说明：\033[0m"
  echo -e "\033[43;37;1m>此脚本只适用于Linux Centos7.x版本环境的安装 其它系统暂不支持\033[0m"
  echo -e "\033[43;37;1m>建议使用阿里云源同时Docker安装的镜像仓库是采用阿里的（国外服务器可以先尝试安装,如果后期不好用再自行更换Docker国外镜像仓库。）\033[0m"
  read -p "请按任意键继续..."
  (chmod 777 ./docker-install.sh)
  echo -e "\033[32;43;5m【即将为您更新本地yum,请稍等...】\033[0m"
  sleep 3s
  (yes y|yum update )
  clear
  echo -e "\033[44;37;2m>>>>>欢迎试用Docker一键自动安装脚<<<<\033[0m"
  echo -e "\033[32;43;2m作者QQ：2966748189 个人博客地址：[http://blog.sjviper.com] \033[0m"
  echo "正在检测系统环境....."
  sleep 3s
  VERSION=$(awk -F= '/^VERSION_ID/{print $2}' /etc/os-release)
  version="\"7\""
  if [ "$VERSION" = "$version" ]; then
     echo -e "\033[36;2m检测系统完毕！当前系统符合脚本运行\033[0m"
     install
  else
     echo -e "\033[47;31;2m【搭建失败！请确保当前系统是Centos 7.x版本】\033[0m"
  fi
}

main

