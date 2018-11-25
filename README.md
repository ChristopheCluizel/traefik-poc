README
===

The goal of this project is to setup a Traefik reverse proxy to route 2 dockerized apps by using HTTPS with Let's Encrypt automatically.

## Traefik & LetsEncrypt doc
https://docs.traefik.io/user-guide/docker-and-lets-encrypt/


## How to setup & run
On AWS console:
* create in Route53 one domain per app (*app1.tinycloud.fr* & *app2.tinycloud.fr* for instance)
* forward this domain towards the EC2 server instance IP which hosts Traefik (here the same instance as for the 2 apps)

On your computer:
* in the *docker-compose.yml*, set the same domain as created above
* deploy this project to the server: `./scripts/deploy.sh`

On the server:
* `./scripts/install.sh` (then log out and log in)
* create the docker network used by the 3 containers: `docker network create web`
* start the Traefik container and the 2 app containers: `./scripts/run.sh`
* to stop and remove the containers: `./scripts/stop.sh`

## Remarks
* In the *traefik_conf/traefik.toml* configuration file, a staging URL is used to get ACME certificate without reaching the rate limit during tests. Comment the line to get a production 
certificate. To ignore the certificate, use the `-k` option with the *curl* command. Example: `curl -X GET "https://app1.tinycloud.fr" -Lk | jq`
* The *traefik_conf/acme.json* file (which will contain the certificate) should be created with `chmod 600` permission.