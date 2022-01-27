all:
	docker-compose --project-directory srcs up -d --build

clean:
	docker-compose --project-directory srcs down

fclean: clean

re: fclean all
