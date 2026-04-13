
# Installation
```bash
docker compose up -d --build
docker compose exec svd_php composer install
docker compose exec svd_php npm ci
```

* Site : http://localhost:8026

# Debug
## Remettre les droits utilisateur linux
```bash
user=$(users | awk '{print $1}')
sudo chown -R "${user}:domain users" .
```

### Licence

Ce projet utilise **Bulma** — un framework CSS open source sous licence [MIT](https://github.com/jgthms/bulma/blob/master/LICENSE).  
Site officiel : [https://bulma.io/](https://bulma.io/)
