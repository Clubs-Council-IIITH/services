# Services

Configurations for services and containers for the Clubs Council Website.

## Setup

- Clone the main repository and submodules (make sure your SSH-key has access to private repos too):

```
git clone -j8 --recurse-submodules --remote-submodules git@github.com:Clubs-Council-IIITH/services.git
cd services
```

## Testing

- To test in local machine run the following script which runs the micro-services in foreground.

```
docker compose up --build
```

- To run the service locally in background, run the following script:

```
docker compose up --build -d
```

- To stop the service, run the following script:

```
docker compose down
```