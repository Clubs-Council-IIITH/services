# Services

Configurations for services and containers.

## Setup
- Clone the main repository and submodules:
```
git clone -j8 --recurse-submodules --remote-submodules git@github.com:Clubs-Council-IIITH/services.git
make pull
```

- Run initialization script:
```
make init
```

- Build and spin up all services:
```
make
```

> For other setup options (automated setup) and data files, please visit the [data repository](https://github.com/Clubs-Council-IIITH/data)

## Using the development makefile
- `make`: Spin up all services.
- `make init`: Initialize project directory.
- `make start S="<service1> <service2> ..."`: Start specified services.
- `make stop S="<service1> <service2> ..."`: Stop specified services.
- `make clean`: Bring down all services and clear volumes and orphans.
- `make logs S="<service1> <service2>"`: Show logs of specified services.
- `make ps`: Show status for all containers of this project.
Pass `ENV=prod` to switch to the production environment.
