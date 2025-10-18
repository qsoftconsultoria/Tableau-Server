

# Guia de Backup do Tableau Server

Este guia explica como usar o script `backup_tableau.sh` para criar backups de configurações e dados do Tableau Server.

## Pré-requisitos
- Tableau Server instalado no RHEL 9.7.
- Usuário `tableau` com acesso ao TSM.
- Mínimo 10GB de espaço livre em `/var/opt/tableau/tableau_server/data/tabsvc/files/backups`.

## Como Executar
1. Torne o script executável:
   ```bash
   chmod +x scripts/backup_tableau.sh
   ```
2. Execute como usuário `tableau`:
   ```bash
   sudo -u tableau ./scripts/backup_tableau.sh
   ```
3. Verifique os arquivos gerados:
   - Configurações: `.json` em `$BACKUP_DIR`.
   - Dados: `.tsbak` em `$BACKUP_DIR`.
   - Log: `/var/log/tableau_backup_YYYYMMDD_HHMMSS.log`.

## Notas
- Agende via cron para backups regulares (ex.: semanal às 2h):
  ```bash
  0 2 * * 0 /caminho/para/backup_tableau.sh
  ```
- Para restauração: Use `tsm settings import -f config.json` e `tsm maintenance restore -f data.tsbak`.
- Faça backup de ativos manuais (ex.: certificados, contas de sistema) fora do TSM.

