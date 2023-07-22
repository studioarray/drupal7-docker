Drupal 7 local docker setup for quick access

How to use:

- `docker compose up -d` to start
- `docker compose down` to stop
- `docker logs [sitename]-docker-drupal-1` for logs
- `docker exec -it [sitename]-docker-drupal-1 bash` for PHP container bash access including `drush`
- access website on `localhost:8080`
- access phpmyadmin on `localhost:9090`
- see docker-compose file for mysql usernames/passwords