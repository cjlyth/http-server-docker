#!/usr/bin/env bash

server_args="${SERVER_DIR:-/data}"
server_args+=" -p ${SERVER_PORT:-8080}"
server_args+=" -a ${SERVER_ADDRESS:-0.0.0.0}"
server_args+=" -e ${SERVER_DEFAULT_EXT:-html}"
${SERVER_CORS:-true}        && server_args+=" --cors"
${SERVER_SILENT:-true}      && server_args+=" -s"
${SERVER_SHOW_DIRS:-true}   && server_args+=" -d"
${SERVER_AUTO_INDEX:-true}  && server_args+=" -i"

http-server ${server_args}
