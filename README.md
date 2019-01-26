# docker-hugo
docker image for static page generator hugo - https://gohugo.io

With this image you can execute each **hugo** command inside the docker container. The source and destination code is mapped to container's internal directories. To avoid permission problems USER_GID and USER_UID of the host user are forwarded to container.

# Build Image

docker build --rm=true --tag=didlich/hugo .

# Run Container with differenct hugo commands

assume the hugo source code is in the root directory and the generated code will reside in 'public' sub directory

## version
the following command will print **hugo** version:

    docker run --rm -it \
            -e USER_GID=$(id -g) \
            -e USER_UID=$(id -u) \
            -p 8082:8082 \
            -v $PWD:/src \
            -v $PWD/public:/dst \
            --name hugo didlich/hugo \
            hugo version

## live server
the next command will start hugo's live server:

    docker run --rm -it \
        -e USER_GID=$(id -g) \
        -e USER_UID=$(id -u) \
        -p 8082:8082 \
        -v $PWD:/src \
        -v $PWD/public:/dst \
        --name hugo didlich/hugo \
        hugo server --baseURL / -b http://localhost:8082 --bind=0.0.0.0 --port 8082 --config ./config.ch.toml --source /src --destination /dst

**IMPORTANT:** the mapped port 8082 need to be set in hugo as --port 8082

## build


    docker run --rm -it \
        -e USER_GID=$(id -g) \
        -e USER_UID=$(id -u) \
        -v $PWD:/src \
        -v $PWD/public:/dst \
        --name hugo didlich/hugo \
        hugo --disableSitemap --buildDrafts --config config.toml --baseURL / --source /src --destination /dst
