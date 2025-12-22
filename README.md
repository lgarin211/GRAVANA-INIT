# GRAVANA-INIT

## Overview
- This workspace is a containerized stack for MySQL, Zabbix (server + web), and Grafana.
- The development environment runs in a Dev Container using Docker-in-Docker.
- **All services (Grafana, MySQL, Zabbix) start automatically when you open this repository in GitHub Codespaces or a Dev Container.**

## Prerequisites
- Docker available inside the Dev Container (already enabled via devcontainer).
- Ports `10051`, `8080`, `3000`, and `10050` are automatically forwarded.

## Automatic Startup
When you open this repository in a devcontainer or codespace:
1. The images will be pulled automatically (on first run)
2. All services will start automatically
3. Ports will be forwarded with labels for easy access

## Manual Control (if needed)
### Start the stack manually
```bash
docker compose -f .devcontainer/docker-compose.yml up -d
```

### Stop and remove the stack
```bash
docker compose -f .devcontainer/docker-compose.yml down
```

### Check service status
```bash
docker compose -f .devcontainer/docker-compose.yml ps
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