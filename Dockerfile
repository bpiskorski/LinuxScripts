FROM ubuntu:22.04

WORKDIR /home

RUN apt update 
RUN apt install -y nano 
RUN apt install -y man-db manpages-posix
RUN apt update && apt install -y ansible

#to run in cmd:
#docker exec -it ubuntu-container bash

CMD ["/bin/bash"]