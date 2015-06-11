FROM registry-ice.ng.bluemix.net/ibmliberty
# copy push shared resources
COPY resources /opt/ibm/wlp/usr/shared/resources/

#copy environment variable file
#COPY env_file /opt/ibm/wlp/etc/server.env
#COPY env_file /opt/ibm/wlp/usr/servers/defaultServer/server.env

# add a key, so we would be able to SSH into containers
COPY id_rsa.pub /root/.ssh/
RUN chmod 700 /root/.ssh/id_rsa.pub
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

EXPOSE 22 
EXPOSE 9080 
EXPOSE 443
#CMD ["/usr/bin/supervisord"]

ADD pushworks-server-Main-SNAPSHOT.war /opt/ibm/wlp/usr/servers/defaultServer/apps/
ADD server.xml /opt/ibm/wlp/usr/servers/defaultServer/

ENV LICENSE accept