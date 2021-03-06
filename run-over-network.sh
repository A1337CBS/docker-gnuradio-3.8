#!/usr/bin/env bash

xhost +local:docker

USER_UID=$(id -u)

CONTAINER_EXIST=`docker ps -a --format "{{.Image}}" | grep gnuradio`

if [ $CONTAINER_EXIST ]; then
    docker start gnuradio
else
    docker run --rm -it \
        --add-host pluto.local:192.168.2.1 \
        --volume /tmp/.X11-unix:/tmp/.X11-unix \
        --volume `pwd`/gnuradio:/home/gnuradio \
        -e DISPLAY=unix$DISPLAY \
        --network host \
        --volume /run/user/${USER_UID}/pulse:/run/user/1000/pulse \
        -v /dev/bus/usb:/dev/bus/usb --privileged \
        --name gnuradio \
        gnuradio
        #bash -lc "/usr/local/bin/uhd_find_devices && /usr/local/bin/uhd_usrp_probe"

fi

#         --name gnuradio \