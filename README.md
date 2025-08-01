
# Installation
```bash
docker compose up -d --build
```

# Debug
## Remettre les droits utilisateur linux
```bash
user=$(users | awk '{print $1}')
sudo chown -R "${user}:domain users" .
```
