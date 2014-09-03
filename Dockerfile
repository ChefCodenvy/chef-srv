FROM	base/chef-server

RUN apt-get update && apt-get -y install sudo curl mc rpm openssh-server openssh-client tree supervisor && mkdir -p /var/log/supervisor
RUN sudo mkdir /var/run/sshd && sudo echo 'root:root' |chpasswd

#ADD $app$/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22 80 443
RUN sudo sed -i.bak 's/\"enable_non_ssl\": false/\"enable_non_ssl\": true/g' /etc/chef-server/chef-server-running.json 
#RUN sudo sed -i.bak 's/https:\/\/b4eec4f5fad6/https:\/\/runner1.codenvy-next.com/g'  /etc/chef-server/chef-server-running.json 

CMD ["/usr/bin/supervisord"]
