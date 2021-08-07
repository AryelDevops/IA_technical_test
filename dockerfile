#Get a image with minimum resources for to run my app clean;
FROM httpd:alpine3.14

#Creating a group and user for to run my app without root user;
#RUN addgroup -S orion && adduser -S arielson -G orion

#Apache for default have this directory and all files as root, so when start container, \
#my user will can't create the file with PID of httpd;
#RUN chown arielson:orion -R /usr/local/apache2

#Switch for user that always will go execute my app;
#USER arielson:orion

#Copy local app for inside image;
COPY ./index.html /usr/local/apache2/htdocs/index.html

#Workdir default always that the container created;
WORKDIR /usr/local/apache2/

#Port that will be expose for external access;
EXPOSE 80

