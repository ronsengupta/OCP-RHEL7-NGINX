# Pull the rhel image from the local repository
FROM rhel7:latest
USER root

MAINTAINER Ron Sengupta

# Fix per https://bugzilla.redhat.com/show_bug.cgi?id=1192200
RUN yum -y install deltarpm yum-utils --disablerepo=*-eus-* --disablerepo=*-htb-* \
    --disablerepo=*-ha-* --disablerepo=*-rt-* --disablerepo=*-lb-* --disablerepo=*-rs-* --disablerepo=*-sap-*

RUN yum-config-manager --disable *-eus-* *-htb-* *-ha-* *-rt-* *-lb-* *-rs-* *-sap-* > /dev/null

COPY nginx.repo /etc/yum.repos.d/nginx.repo
RUN chmod 777 /etc/yum.repos.d/nginx.repo 

RUN yum update -y; yum install nginx -y

<<<<<<< HEAD
RUN mkdir -p /etc/nginx/certs
RUN mkdir -p /var/www/html

COPY default /etc/nginx/conf.d/default.conf
COPY purple.rhel-cdk.10.1.2.2.xip.io.crt /etc/nginx/certs/server.crt
COPY purple.rhel-cdk.10.1.2.2.xip.io.key /etc/nginx/certs/server.key
COPY destca.crt /etc/nginx/certs/ca.crt

RUN echo "The Nginx Web Server is Running" > /var/www/html/index.html

#EXPOSE 80
=======
#RUN echo "The Web Server is Running" > /var/www/html/index.html
#RUN echo "Listen 8080" >> /etc/httpd/conf/httpd.conf
#COPY ssl.conf /etc/httpd/conf.d/ssl.conf
#COPY ca.crt /etc/pki/tls/certs/ca-bundle.crt
#COPY clisec.rhel-cdk.10.1.2.2.xip.io.crt /etc/pki/tls/certs/localhost.crt
#COPY clisec.rhel-cdk.10.1.2.2.xip.io.key /etc/pki/tls/private/localhost.key

EXPOSE 80
>>>>>>> 2e48d47d8c54ed9df170e47ecd6668d40a23f132
EXPOSE 443


# Define default command.

CMD ["nginx", "-g", "daemon off;"]
