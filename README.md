# Documentation
Explicitly creating a network is necessary for intercommunication between MPI nodes by hostname.

## Create a network
    docker network create mpi-net

## Create a shared volume
    docker volume create mpi-vol

## Build the image
    docker build -t cemti/mpi-node .

## Run sample containers
    docker run -d --name mpi1 --network mpi-net --volume=mpi-vol:/root/mpi -p 800:22 cemti/mpi-node
    docker run -d --name mpi2 --network mpi-net --volume=mpi-vol:/root/mpi cemti/mpi-node

## Connect to the exposed container via SSH
    ssh -p 800 root@localhost

## Testing
    root@localhost's password:
    Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 6.4.16-linuxkit x86_64)
    
     * Documentation:  https://help.ubuntu.com
     * Management:     https://landscape.canonical.com
     * Support:        https://ubuntu.com/advantage
    
    This system has been minimized by removing packages and content that are
    not required on a system that users do not log into.
    
    To restore this content, you can run the 'unminimize' command.
    Last login: Mon Nov 20 01:22:52 2023 from 192.168.65.1
    root@3b6815b993e2:~# ping mpi2
    PING mpi2 (172.19.0.3) 56(84) bytes of data.
    64 bytes from mpi2.mpi-net (172.19.0.3): icmp_seq=1 ttl=64 time=0.049 ms
    64 bytes from mpi2.mpi-net (172.19.0.3): icmp_seq=2 ttl=64 time=0.050 ms
    ^C
    --- mpi2 ping statistics ---
    2 packets transmitted, 2 received, 0% packet loss, time 1002ms
    rtt min/avg/max/mdev = 0.049/0.049/0.050/0.000 ms

## Compile and run an MPI program
    root@3b6815b993e2:~# cd mpi
    root@3b6815b993e2:~/mpi# pwd
    /root/mpi
    root@3b6815b993e2:~/mpi# nano text.cpp
    root@3b6815b993e2:~/mpi# mpicxx test.cpp
    root@3b6815b993e2:~/mpi# mpiexec -host mpi1:2,mpi2:4 ./a.out
    Salutare de la un proces cu rankul 0 de pe nodul 3b6815b993e2
    Salutare de la un proces cu rankul 1 de pe nodul 3b6815b993e2
    Salutare de la un proces cu rankul 2 de pe nodul e00bee6b2035
    Salutare de la un proces cu rankul 3 de pe nodul e00bee6b2035
    Salutare de la un proces cu rankul 4 de pe nodul e00bee6b2035
    Salutare de la un proces cu rankul 5 de pe nodul e00bee6b2035
