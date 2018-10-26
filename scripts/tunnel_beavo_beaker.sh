#!/bin/bash
#
# create a tunnel between beavo and beaker.

# beavo is running MongoDB client
# beaker is running MongoDB server
BEAVO="34.204.87.164"
BEAKER="100.24.209.158"

# if the script is run from beavo,
# it is run forward (client to server)
# and uses ssh -L to tunnel
# from beavo:27017 --> beaker:27017
[ "$HOSTNAME" == "beavo" ] && /usr/bin/ssh -f -N -L 27017:localhost:27017 ubuntu@${BEAKER} 

# if the script is run from beaker,
# is is run in reverse (server to client)
# and uses ssh -R to tunnel
# from beavo:27017 -- beaker:27017
[ "$HOSTNAME" == "beaker" ] && /usr/bin/ssh -f -N -R 27017:localhost:27017 ubuntu@${BEAVO}

