
FROM oraclelinux:7-slim
 
# Create app directory
WORKDIR /usr/src/app
#  
#  # Copy all files from your host machine into the new app directory
COPY * ./
#ADD *.js ./
#   
#   # Update Oracle Linux
#   # Install Node.js
#   # Install the Oracle Instant Client
#   # Check that Node.js and NPM installed correctly
#   # Install the OracleDB driver
RUN yum update -y && \
  yum install -y oracle-release-el7 && \
  yum install -y oracle-nodejs-release-el7 && \
#  yum install -y --disablerepo=ol7_developer_EPEL nodejs && \
  yum install -y nodejs && \
  yum install -y oracle-instantclient19.3-basic.x86_64 && \
  yum clean all && \
  node --version && \
  npm --version && \
  npm install oracledb && \
  npm install python3 && \
  npm install node-gyp@9.4.0 && \
  npm install canvas && \
  npm install express && \
  npm install body-parser && \
#  npm audit fix --force && \
#  npm audit fix && \
#  npm audit && \
  echo Installed
        
RUN chmod +x ./server.js
#RUN sudo setcap 'cap_net_bind_service=+ep' `which node`
CMD ["node", "server.js"]
