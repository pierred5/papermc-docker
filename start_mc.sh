#!/bin/bash
set -eux
clean_up () {
    echo 'Stopping minecraft world1' ;
    mscs stop world1 ;
}
trap clean_up TERM

# main()
mscs start world1
sleep 10s
ps -efH
sleep 10s
wait $(cat worlds/world1.pid)

