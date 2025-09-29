# Services

Configurations for services and containers for the Clubs Council Website.

## Setup

- Clone the main repository and submodules (make sure your SSH-key has access to private repos too):

```bash
git clone -j8 --recurse-submodules --remote-submodules git@github.com:Clubs-Council-IIITH/services.git
cd services
```

## Testing

- To test in local machine run the following script which runs the micro-services in foreground.

```bash
docker compose -p services up --build
```

- To run the service locally in background, run the following script:

```bash
docker compose -p services up --build -d
```

- To stop the service, run the following script:

```bash
docker compose -p services down
```

## Deployment

To run deployment related tasks, run the following script:

```bash
./deploy.sh <option>
```
with the following options:
- `setup` - To setup the deployment environment and adding the remote repository.
- `prod` - To deploy the services in production environment.
- `staging` - To deploy the services in staging environment.
- `submodules` - To update all of the submodules on the server.
- `github` - To update the submodules and repository on GitHub. This also prunes the old remote branch references from your local repository, to be in sync with the remote repository.
- `*` - To see the list of available options.

_NOTE_: The above script assumes that you have the necessary permissions to deploy the services.
