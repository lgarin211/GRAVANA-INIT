# GRAVANA-INIT

## Overview
- This workspace is a containerized stack for MySQL, Zabbix (server + web), and Grafana.
- The development environment runs in a Dev Container using Docker-in-Docker.

## Prerequisites
- Docker available inside the Dev Container (already enabled via devcontainer).
- Ports `10051`, `8080`, and `3000` free on your host.

## Start the stack
```bash
docker compose -f .devcontainer/docker-compose.yml pull
docker compose -f .devcontainer/docker-compose.yml up -d
```

## Stop and remove the stack
```bash
docker compose -f .devcontainer/docker-compose.yml down
```

## Services & URLs
- Grafana: http://localhost:3000
	- Plugins: installs `alexanderzobnin-zabbix-app` automatically.
- Zabbix Web: http://localhost:8080
- Zabbix Server: port `10051` exposed.

## Database credentials (configured via compose)
- Database: `zabbix`
- User: `zabbix`
- Password: `zabbix_pwd`
- Root Password: `root_pwd`

## Notes
- Data persists in Docker volumes: `mysql_data`, `grafana_data`.
- You can adjust environment variables and ports in `.devcontainer/docker-compose.yml`.