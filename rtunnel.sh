#!/bin/bash

## Simple, persistent reverse ssh tunnel.
##  Creates a tunnel between a random port 
##  on $_SRV and $_LPORT on localhost.
##
## This is free software.
## Danja Vasiliev, danja@k0a1a.net

_SRV='hostname'
_SPORT=22   ## SSH port on the server
_LPORT=22   ## Local portto be forwarded
_USR='username'

while :; do
    ssh -N -T -R 0:localhost:"$_LPORT" "$_USR"@"$_SRV" -p"$_PORT" \
        -o ExitOnForwardFailure=yes -o ServerAliveInterval=5 \
        -o ConnectTimeout=5 -o ConnectionAttempts=5 \
        -y \
        ## two lines below specific to dropbear ssh client
        #-K 60 -I 120 \
        #-i /root/.ssh/id_rsa \
        ## enable logging or not
        #&> /tmp/rtunnel.log
        #&> /dev/null
    _ERR=$?

    [[ $_ERR -gt 0 ]] && sleep 10
done
