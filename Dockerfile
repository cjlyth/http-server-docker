FROM dockerfile/nodejs

MAINTAINER  Christopher Lyth <cjlyth@gmail.com>
ENTRYPOINT ["/usr/bin/env"]

RUN locale-gen en_US en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8 LC_MESSAGES=POSIX

RUN	apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
	build-essential \
	libgnome-keyring-dev \
	--no-install-recommends

ENV CI true
ENV NPM_CONFIG_UNSAFE_PERM true
ENV NPM_CONFIG_YES true
ENV NPM_CONFIG_NPAT false
ENV NPM_CONFIG_LOGLEVEL warn
ENV BOWER_ALLOW_ROOT true
ENV BOWER_LOG_LEVEL debug

RUN npm install -g http-server

VOLUME ["/data"]
WORKDIR /data

EXPOSE 8080
ENV SERVER_PORT 8080
ENV SERVER_ADDRESS 0.0.0.0

ENV SERVER_CORS true
ENV SERVER_SILENT false
ENV SERVER_CACHE_TIME 10
ENV SERVER_SHOW_DIRS true
ENV SERVER_AUTO_INDEX true
ENV SERVER_DEFAULT_EXT html
ENV SERVER_DIR /data

ADD serve.sh /usr/local/bin/serve
RUN chmod +x  /usr/local/bin/serve

CMD ["/usr/local/bin/serve"]
