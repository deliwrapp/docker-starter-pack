# Docker-Starter-Pack

Docker Starter Pack

- _Version : 1.0.0_
- _Year : 2023_
- _Description : skeleton for docker app_

## Installation with docker

- [https://docs.docker.com/install/linux/docker-ce/ubuntu/](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
- [https://docs.docker.com/install/linux/linux-postinstall/](https://docs.docker.com/install/linux/linux-postinstall/)

### Docker hosts

- Web server [http://localhost](http://localhost)
- PhpMyAdmin [http://localhost:8585](http://localhost:8585)
- MailDev [http://localhost:8787](http://localhost:8787)
- MySQL DataBase `localhost:8383:3306`

ATTENTION, par defaut le WEB SERVER utilise le port 80, vous DEVEZ donc stoper tout programme utilisant le port 80 ou définir votre propre configuration.

Pour utiliser une adresse local comme celle pré-configuré :
- Web server [http://app.local](http://app.local)

Ajouter l'adresse au fichier host 

```
127.0.0.1   app.local
```
LINUX   =>  /etc/hosts
MAC     =>  /etc/hosts
WINDOW  =>  C:\Windows\ System32\drivers\etc\hosts

Si vous souhaitez utiliser une autre adresse que "app.local", penser à modifier les fichiers de config d'apache

- app.local.conf

ainsi que :
1) le Dockerfile d'apache 
2) le docker-compose
-   extra_hosts:
     - "app.local:127.0.0.1"
- hostname: app.local
- domainname: local

ATTENTION, si vous modifier le PORT 80 d'entrée, vous DEVREZ passer par un proxy sur votre machine pour réorienté sur le bon port d'écoute.



### Usage

The code is run inside some docker container.

- `docker-compose build` Build your containers
- `docker-compose up -d` Run yours containers
- `make deploy-dev` Build the project

### Day-to-day usages

The code is run inside some docker container.

- `docker-compose up -d --force-recreate` Recreate your containers
- `docker exec -it triptic_php bash` Get a bash terminal on docker php
- `docker rm $(docker stop $( docker ps -a -q))` Remove your containers
- `docker-compose up -d --force-recreate` Recreate your containers
- `docker system prune -a --volumes` Remove ALL your docker data (except running containers)
- `make fixtures` Run fixtures
- `make build-dev` Build assets for dev environment
- `make build-dev-watch` Watch assets for dev environment
- `make build-prod` Build assets for Prod environment

## APP ACCESS
Executer l'app
Dans un navigateur entrez l'url "localhost:8181"

# HOW TO USE YOU DOCKER STARTER PACK

Cloner le projet à la racine de ce projet
```
git clone ...
```

## BUILD
Créer un build des containers
```
docker-compose build
```

## RUN
Ensuite executer la commande, pour initialiser tous les containers
```
docker-compose up -d
```

OU bien

```
docker-compose up
```

## BUILD and RUN
Commande pour lancer le build et le run des container
```
docker-compose up -d --build
```

## CONTAINER BASH ACCESS
Pour lancer un bash et rentrer dans le container de l'app
```
docker exec -it app_php bash
```

## USEFUL COMMANDS

### CONTAINER COMMANDS
Pour afficher tout vos containers
```
docker ps -a
```

Pour stopper un container
```
docker stop <docker_container_name>
```

Pour stopper tous les containers
```
docker stop $(docker ps -a -q)
```

Pour supprimer un container
```
docker rm -f <docker_container_name>

docker rm -f <docker_container_id>
```

Pour supprimer tous les containers
```
docker rm $(docker ps -a -q)
```

Pour supprimer tous les containers déjà stoppés
```
docker container prune

```

### IMAGE COMMANDS
Pour supprimer une image
```
docker rmi image_id

docker rmi image_id_1 image_id_2
```

Pour supprimer une image via son tag
```
docker rmi -f tag_name
```

Pour supprimer toutes les images inutilisées
```
docker image prune -a
```
OU
```
docker rmi $(docker images -a -q)
```

Pour supprimer toutes les images
```
docker rmi $ (docker images -a -q)
```

### VOLUME COMMANDS
Pour supprimer un volume
```
docker volume rm volume_name

docker volume rm volume_name1 volume_name2
```

Pour supprimer tous les volumes
```
docker volume rm $(docker volume ls -q)
```

### NETWORK COMMANDS
Pour supprimer un network
```
docker network rm network_name_or_id
```

Pour supprimer tous les networks
```
docker network prune
```

### GLOBAL COMMANDS
Pour supprimer toutes les images, networks, volumes, containers inutilisés
```
docker system prune
```

Pour supprimer tous les objets créés par un docker-compose
```
docker-compose down --rmi all -v --remove-orphans
```

Pour supprimer toutes les images et containers
```
docker ps -a
```

Par défaut, les volumes ne sont pas supprimés pour empêcher la suppression de données importantes si aucun conteneur n'utilise actuellement le volume. Utilisez l'indicateur --volumes lors de l'exécution de la commande pour élaguer également les volumes :
```
docker system prune -a --volumes
```
