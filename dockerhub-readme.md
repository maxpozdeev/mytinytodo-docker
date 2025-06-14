Sources  - https://github.com/maxpozdeev/mytinytodo-docker

# Example

```
docker run --rm --name mytinytodo -p 8080:80 -v "$PWD/html":/var/www/html \
    maxpozdeev/mytinytodo:1.8-apache
```

# Examples of compose.yml for docker-compose

### SQLite

```
volumes:
  html:
services:
  web:
    image: maxpozdeev/mytinytodo:1.8-apache
    ports:
      - 8080:80
    restart: unless-stopped
    environment:
      - MTT_DB_TYPE=sqlite
    volumes:
      - html:/var/www/html
```

### MariaDB

```
volumes:
  db_data:
  html_data:
  
services:
  db:
    image: mariadb:10.11
    restart: unless-stopped
    environment:
      - MARIADB_ROOT_PASSWORD=mttRoot
      - MARIADB_USER=mtt
      - MARIADB_PASSWORD=mtt
      - MARIADB_DATABASE=mytinytodo
    volumes:
      - db_data:/var/lib/mysql
    expose:
      - 3306
  web:
    image: maxpozdeev/mytinytodo:1.8-apache
    ports:
      - 80:80
    restart: unless-stopped
    environment:
      - MTT_DB_TYPE=mysql
      - MTT_DB_HOST=db
      - MTT_DB_NAME=mytinytodo
      - MTT_DB_USER=mtt
      - MTT_DB_PASSWORD=mtt
      - MTT_DB_PREFIX=mtt_
      - MTT_DB_DRIVER=pdo  
    volumes:
      - html_data:/var/www/html
```

### PostgreSQL

```
volumes:
  db_data:
  html_data:
  
services:
  db:
    image: postgres:16
    restart: unless-stopped
    environment:
      POSTGRES_PASSWORD: mtt
      POSTGRES_USER: mtt
      POSTGRES_DB: mytinytodo
    volumes:
      - db_data:/var/lib/postgresql/data
  web:
    image: maxpozdeev/mytinytodo:1.8-apache
    ports:
      - 80:80
    restart: unless-stopped
    environment:
      - MTT_DB_TYPE=postgres
      - MTT_DB_HOST=db
      - MTT_DB_NAME=mytinytodo
      - MTT_DB_USER=mtt
      - MTT_DB_PASSWORD=mtt
      - MTT_DB_PREFIX=mtt_
    volumes:
      - html_data:/var/www/html
```

# Upgrade

To use new version of myTinyTodo:

- Pull new image from the registry and recreate container:   
  `docker-compose down && docker-compose build --pull && docker-compose up`
- Execute in the running container:  
  `/usr/local/bin/reinstall-mytinytodo.sh`