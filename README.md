# Services

Configurations for services and containers.

## Setup
Clone the main repository:
```
git clone https://github.com/Clubs-Council-IIITH/services.git
```

Inside it, clone the service repositories:
```
git clone https://github.com/Clubs-Council-IIITH/composer.git
git clone https://github.com/Clubs-Council-IIITH/gateway.git

git clone https://github.com/Clubs-Council-IIITH/auth.git
git clone https://github.com/Clubs-Council-IIITH/users.git

git clone https://github.com/Clubs-Council-IIITH/clubs.git
git clone https://github.com/Clubs-Council-IIITH/events.git
git clone https://github.com/Clubs-Council-IIITH/discussion.git
git clone https://github.com/Clubs-Council-IIITH/mailing.git
```

Copy .env file:
```
cp .env.example .env
```

Build and spin up all services:
```
docker compose up --build -d
```
