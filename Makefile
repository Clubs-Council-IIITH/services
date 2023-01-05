dc=docker-compose

all:
	$(dc) up --build -d
	
start:
	$(dc) up $(s) --build -d

stop:
	$(dc) stop $(s)

restart:
	$(dc) stop $(s)
	$(dc) up $(s) --build -d

clean:
	$(dc) down -v --remove-orphans