# This is Makefile for inception project
NAME			= inception

# docker-compose
# Options:
#  -p, --project-name NAME     Specify an alternate project name
#                              (default: directory name)
DOCKER-COMPOSE		= docker-compose --project-directory srcs

.PHONY	: all
all	: $(NAME)

# docker-compose up
# Options:
#    -d, --detach               Detached mode: Run containers in the background,
#                               print new container names. Incompatible with
#                               --abort-on-container-exit.
#    --build                    Build images before starting containers.
$(NAME)	:
	$(DOCKER-COMPOSE) up --detach --build

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
	sudo docker system prune --volumes --all --force

.PHONY	: re
re	: fclean all
