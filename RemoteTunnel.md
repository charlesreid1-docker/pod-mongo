# Remote SSH Tunnel

To maintain secure connections to the MongoDB
client and server, we make connections over
an SSH connection, using trusty old reliable SSH
to secure all communications.

## forward tunnels

To build a forward tunnel (from client to server),
use the `-L` flag with SSH, which forwards traffic
from a local machine port to a remote machine port.

The syntax is 

```
ssh -L <local-port>:localhost:<remote-port>
```

To forward traffic between local machine port 4321 and
remote machine port 27017, making the remote MongoDB
database available on the local machine 
via port 4321, you would first create an
SSH tunnel:

```
ssh -i ~/.ssh/my_secure_key \
-L 4321:localhost:27017 \
user@mongo-node
```

then you would fire up the tunnel,
start MongoDB on the remote server,
and check that port 4321 is open:

```
netstat -tulpn
```

## reverse tunnels

To build a reverse tunnel (from server to client),
use the `-R` flag with SSH, which forwards traffic
from a remote machine port to a local machine port.

To forward traffic from a remote machine port 4321
and a local machine port 27017, you would do,

```
ssh -i ~/.ssh/my_secure_key \
-R 27017:localhost:4321 \
user@mongo-node
```


## links

[Link to Digital Ocean guide](https://www.digitalocean.com/community/tutorials/how-to-securely-configure-a-production-mongodb-server)

