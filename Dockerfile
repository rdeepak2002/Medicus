FROM node:7
WORKDIR /app
RUN wget https://www.dropbox.com/s/olh4fakkmrc1rkx/WolframScript_11.3.0_LINUX64_amd64.deb?dl=1
RUN dpkg -i WolframScript_11.3.0_LINUX64_amd64.deb\?dl\=1
COPY package.json /app
RUN npm install
COPY . /app
CMD node server.js
EXPOSE 8080