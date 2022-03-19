# project_script

Script project bash

### Testing on docker
use bash builder.sh -debug or use the command bellow
```bash
docker build -t test . && \
docker run --rm -it --entrypoint bash --name ubuntu -v $PWD:/home/teste/auto ubuntu
```
