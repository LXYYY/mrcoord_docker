.PHONY: build run attach

build:
	docker build -t mrcoord --build-arg myuser=${shell whoami} .

run:
	docker run --rm -it --name mrcoord\
		--cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
			--gpus all \
			-e DISPLAY=${DISPLAY} \
			-e QT_X11_NO_MITSHM=1 \
			-e XAUTHORITY=/tmp/.docker.xauth \
			-e HOME=${HOME} \
			-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
			-v /tmp/.docker.xauth:/tmp/.docker.xauth \
			-v ${HOME}/Datasets:${HOME}/Datasets \
			-v ${HOME}/Workspace/mrslam/coscan_ws:${HOME}/Workspace/mrslam/coscan_ws/ \
			-v /etc/localtime:/etc/localtime \
			--runtime=nvidia \
			mrcood

attach:
	docker exec -it -u ${shell whoami} mrcood /bin/bash
