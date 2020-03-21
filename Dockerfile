FROM node:13
WORKDIR /usr/src/app

RUN apt-get update
RUN apt-get install -y mc nano net-tools nmap netcat
RUN git clone https://github.com/keplergl/kepler.gl

RUN mkdir /usr/src/app/demo-app
RUN cp -R kepler.gl/examples/demo-app/* demo-app
RUN cp -R kepler.gl/examples/demo-app/.babelrc demo-app

WORKDIR /usr/src/app/demo-app
RUN yarn --ignore-engines

ENV CartoClientId ChangeMe
ENV DropboxClientId ChangeMe
ENV MapboxAccessToken ChangeMe
ENV MapboxExportToken ChangeMe

EXPOSE 8080
ENTRYPOINT ["node", "node_modules/webpack-dev-server/bin/webpack-dev-server.js", "--mode", "development", "--progress", "--hot", "--open", "--host", "kepler-gl","--allowed-hosts","kepler-gl"]
