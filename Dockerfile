FROM ubuntu:22.04

WORKDIR /home

RUN apt update 
RUN apt install -y nano 
RUN chmod +x /home/scripts/executable.sh
RUN /home/scripts/executable.sh

#to run in cmd:
#docker exec -it ubuntu-container bash

CMD ["/bin/bash"]