# Remote SSH Tunnel

To maintain secure connections to the MongoDB
client and server, we make connections over
an SSH connection, using trusty old reliable SSH
to secure all communications.

To do this, use the `-L` flag with SSH, which
does port forwarding between the remote and 
local machine.

The syntax is 

```
ssh -L <local-port>:localhost:<remote-port>
```

To forward traffic between local port 4321 and
remote port 27017, making the remote MongoDB
database available on the local machine 
via port 4321, you would first create an
SSH tunnel:

```
ssh -i ~/.ssh/my_secure_key \
-L 4321:localhost:27017 \
ssh_user@mongo_db_droplet_host_or_ip
```

then you would fire up the tunnel,
start MongoDB on the remote server,
and check that port 4321 is open:

```
netstat -tulpn
```

[Link to Digital Ocean guide](https://www.digitalocean.com/community/tutorials/how-to-securely-configure-a-production-mongodb-server)

