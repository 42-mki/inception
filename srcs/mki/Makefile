# This is Makefile for inception project
NAME			= inception
DATA_PATH		= /home/mki/data

# docker-compose
# Options:
#  -p, --project-name NAME     Specify an alternate project name
#                              (default: directory name)
DOCKER-COMPOSE		= docker-compose --project-directory ./srcs

.PHONY	: all
all	: $(NAME)

# docker-compose up
# Options:
#    -d, --detach               Detached mode: Run containers in the background,
#                               print new container names. Incompatible with
#                               --abort-on-container-exit.
#    --build                    Build images before starting containers.
# make directory for volumes
$(NAME)	:
	sed '/mki/d' /etc/hosts
	echo "127.0.0.1/tmki.42.fr" >> /etc/hosts
	mkdir -p $(DATA_PATH)
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress
	$(DOCKER-COMPOSE) up -d --build

# docker-compose down
.PHONY	: clean
clean	:
	$(DOCKER-COMPOSE) down

# docker system prune: https://docs.docker.com/engine/reference/commandline/system_prune/
# docker network prune: https://docs.docker.com/engine/reference/commandline/network_prune/
# docker volume prune: https://docs.docker.com/engine/reference/commandline/volume_prune/
# fclean	: docker-compose down and rm all files
#	sudo docker container prune --force
#	sudo docker image prune --force
#	sudo docker network prune --force
#	sudo docker volume prune --force
.PHONY	: fclean
fclean	: clean
	rm -rf $(DATA_PATH)

.PHONY	: re
re	: fclean all
