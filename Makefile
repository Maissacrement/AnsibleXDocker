#!make

NAME               = ubu
DOCKER             = docker
DOCKER_MACHINE    := `${DOCKER} ps -aqf "ancestor=${NAME}"`
DOCKER_MACHINE_IP  = 172.17.0.2

ssh_link:
	@echo -e "ssh copy connection"
	@linux/ssh_remote_host.sh ${DOCKER_MACHINE}

ssh_connect:
	@ssh root@${DOCKER_MACHINE_IP} -p 22

ssh: ssh_link ssh_connect

build:
	docker build -t ${NAME} . 

run:
	docker run -it --rm ${NAME}

$(NAME): build run
