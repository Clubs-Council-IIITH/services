# Services

Configurations for services and containers.

## Setup
Clone the main repository and submodules:
```
git clone -j8 --recurse-submodules --remote-submodules git@github.com:Clubs-Council-IIITH/services.git
```

Copy .env file:
```
cp .env.example .env
```

Build and spin up all services:
```
make
```

## Using the development makefile
- `make`: Spin up all services.
- `make start s="<service1> <service2> ..."`: Start specified services.
- `make stop s="<service1> <service2> ..."`: Stop specified services.
- `make restart s="<service1> <service2> ..."`: Restart specified services.
- `make clean`: Bring down all services and clear volumes and orphans.
