#!/bin/bash
set -eux
clean_up () {
    echo 'Stopping minecraft world1'
    mscs stop world1
    sleep 15s
    exit 0
}
trap 'kill ${!}; clean_up' SIGTERM SIGKILL

# main()
echo 'Starting minecraft world1'
mscs start world1
sleep 5s
ps -f $(cat worlds/world1.pid)

tail -f /dev/null & wait "$!"
