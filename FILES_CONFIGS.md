## On $HOME/.bashrc
```bash
RESET="\u001b[0m"
CYAN="\u001b[36m"

alias dockerps="echo -e '${CYAN}Running docker ps ${RESET}' \
&& docker ps && echo -e '\n' \
&& echo -e '${CYAN}Running docker container ls -a${RESET}' \
&& docker container ls -a && echo -e '\n' \
&& echo -e '${CYAN}Running docker volume ls${RESET}' \
&& docker volume ls && echo -e '\n' \
&& echo -e '${CYAN}Running docker images${RESET}' \
&& docker images
"
```