FROM phusion/baseimage:0.9.11

ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

RUN apt-get update
RUN apt-get -y install build-essential 
RUN apt-get -y install elfutils libelf1 libelf-dev 
RUN apt-get -y install libglib2.0-dev 
RUN apt-get -y install gcc-avr gdb-avr avr-libc git
RUN git clone https://github.com/buserror/simavr.git
RUN cd /simavr && make build-simavr
RUN cd /simavr && make build-tests
RUN cd /simavr && make install
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
