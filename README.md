


I create a script with contents like this next to a directory I want to serve

```shell
#!/usr/bin/env bash
docker run -d \
  --name="cjlyth_github_io" \
   -p 80:8080 \
   -v $(pwd)/cjlyth.github.io:/data \
   cjlyth/http-server	

```

mine is a little more complex but for the purpose of this readme, lets leave it at that...


... ok so here is the one im using as of this commit date

```shell
#!/usr/bin/env bash
DATA_DIR="$( cd ${1:-.} && pwd )"
[[ -d "${DATA_DIR?}" ]] || {
	echo "Unable to find directory: ${DATA_DIR}"
	exit 1
}
CONTAINER_NAME="$(basename ${2:-${DATA_DIR}})"
docker restart ${CONTAINER_NAME?} &> /dev/null && {
	echo "Docker container '${CONTAINER_NAME}' restarted"
} || {
	echo "Running docker image 'cjlyth/http-server' as '${CONTAINER_NAME}'"
	docker run -d -P \
	  --name="$CONTAINER_NAME" \
	   -v $DATA_DIR:/data \
	   cjlyth/http-server	|| {
	   	docker stop $CONTAINER_NAME | xargs --no-run-if-empty docker rm
	   	exit 2
	   }
}
docker port $CONTAINER_NAME 8080 | xargs --no-run-if-empty -I{} xdg-open http://{} 1>/dev/null
```

with the above script you can serve a directory like so `./start.sh ./cjlyth.github.io/`