# Ubuntu + supervisord (SSH preinstalled)

Credits: @cloudbec

1. Build. `docker build -t ubuntu/supervisord .
2. Run. `docker run -d -p 0.0.0.0:2222:22 ubuntu/supervisord`

# SSH password

The first time that you run your container, a random password will be generated
for user `root`. To get the password, check the logs of the container by running:

```
docker logs <CONTAINER_ID>
```

You will see an output like the following:

```
	========================================================================
	You can now connect to this Ubuntu container via SSH using:

	    ssh -p <port> root@<host>
	and enter the root password 'U0iSGVUCr7W3' when prompted

	Please remember to change the above password as soon as possible!
	========================================================================
```

In this case, `U0iSGVUCr7W3` is the password allocated to the `root` user.

### Setting a specific password for the root account

If you want to use a preset password instead of a random generated one, you can
set the environment variable `ROOT_PASS` to your specific password when running the container:

```
docker run -d -p 0.0.0.0:2222:22 -e ROOT_PASS="mypass" ubuntu/supervisord
```

# Deactivating ssh server

You may not like to have a running ssh server use SSH_SERVER=false to prevent starting it. Default is true


```
docker run -e SSH_SERVER=false ubuntu/supervisord
```

# Default ports

- 22
- 8000..8009
