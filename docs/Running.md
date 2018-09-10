# pod-mongo: Running

Use `docker-compose` to run the pod.

## The Docker Compose File

The `docker-compose.yml` file contains all the directives needed
to run a MongoDB docker pod.

Why use docker-compose instead of docker? 
docker-compose is the preferred way to run multiple containers.

**Huh? Where's docker-compose.yml??**

Instead of a `docker-compose.yml` file, 
you'll see a `docker-compose.fixme.yml` file.
You need to fix this YML file by hard-coding 
a password into the file.

<a name="RunningCLI"></a>
## Running Mongo Docker Pod from Command Line

We start by covering how to run the docker pod from the command line.

First, set the MySQL password using a sed one-liner:

```
$ sed "s/REPLACEME/YoFooThisIsYourNewPassword/" docker-compose.fixme.yml > docker-compose.yml
```

Now you can run the container pod with

```
docker-compose up       # interactive
docker-compose up -d    # detached
```

or, if you want to rebuild all the containers before running up,

```
docker-compose up --build
```

If you just want to rebuild the containers,

```
docker-compose build
```

and this will rebuild the containers from scratch:

```
docker-compose build --no-cache
```

***WARNING:*** for large, complicated container images,
this command can take a very long time.
Use with care.)

You can restart all containers in a pod using the restart command:

```
docker-compose restart
```

***WARNING:*** this will ***NOT*** pick up changes to 
Dockerfiles or to files that are mounted into the container.
This simply restarts the container using the same image 
(in memory) that was previously running, ***without***
getting an up-to-date container image.


<a name="RunningService"></a>
## Running Mongo Docker Pod as Startup Service

If you want to run the pod as a startup service,
see the dotfiles/debian repository, in the services/
subdirectory. You will find a systemd service
that will start/stop the docker pod.

**`dockerpod-mongo.service:`**

```
[Unit]
Description=mongo docker pod
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStart=/usr/local/bin/docker-compose -f /home/charles/codes/docker/pod-mongo/docker-compose.yml up
ExecStop=/usr/local/bin/docker-compose  -f /home/charles/codes/docker/pod-mongo/docker-compose.yml stop

[Install]
WantedBy=default.target
```

Now install the service to `/etc/systemd/system/dockerpod-mongo.servce`,
and activate it:

```
sudo systemctl enable dockerpod-mongo.service
```

Now you can start/stop the service with:

```
sudo systemctl (start|stop) dockerpod-mongo.service
```

NOTE: if you need to debug the containers, 
or update any config files copied into the container,
be sure and stop the service before doing a 
`docker-compose stop` or a `docker-compose up --build`,
otherwise the pod will continually respawn.


<a name="Workflow"></a>
## Workflow for Mongo Docker Pod Updates

This section covers a workflow if you're updating the docker pod.

As noted abobve, a simple `docker-compose restart` won't pick up
changes in Dockerfiles or files mounted into the image, so 
you often need to stop the containers and restart them after 
rebuilding the container images.

However, if you update your files (particularly if you add a lot of new 
apt packages), it can take a long time to build the containers.
This can result in a lot of downtime if you take the containers down
before rebuilding them.

To minimize downtime, use the following workflow:

* Run `docker-compose build` to rebuild the images, leaving the pod running (they are not affected)
* Run `docker-compose down` to bring the pod down
* Run `docker-compose up` to bring the pod up

It may take a few seconds to bring the pod down,
and that will be your total amount of downtime.

