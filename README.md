Drupal 7 local docker setup for quick access

How to use:

- `cp .env.example .env` and change `CONTAINER_NAME` as you prefer
- put drupal 7 files in `public_html` folder
- `docker compose up -d` to start
- `docker compose down` to stop
- `docker logs [CONTAINER_NAME]` for logs
- `docker exec -it [CONTAINER_NAME] bash` for PHP container bash access including `drush`
- access website on `localhost:8080`
- access phpmyadmin on `localhost:9090`
- see docker-compose file for mysql usernames/passwords
- add database either through drush or phpmyadmin