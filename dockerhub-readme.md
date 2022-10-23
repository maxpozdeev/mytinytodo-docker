Sources  - https://github.com/maxpozdeev/mytinytodo-docker

# Examples of compose.yml for docker-compose

Use Sqlite:

```
volumes:
  html:
services:
  web:
    image: maxpozdeev/mytinytodo:1.7-apache
    ports:
      - 8081:80
    restart: always
    environment:
      - MTT_DB_TYPE=sqlite
    volumes:
      - html:/var/www/html
```

Use MariaDB:

```
volumes:
  db_data:
  html_data:
  
services:
  db:
    image: mariadb:10.6
    restart: always
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
    image: maxpozdeev/mytinytodo:1.7-apache
    ports:
      - 80:80
    restart: always
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

# Upgrade

To use new version of myTinyTodo:

- Pull new image from hub and recreate container:   
  `docker-compose down && docker-compose build --pull && docker-compose up`
- Execute in the running container:  
  `/usr/local/bin/reinstall-mytinytodo.sh`