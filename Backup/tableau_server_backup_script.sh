

#!/bin/bash

# Script para backup do Tableau Server (configurações e dados)
# Execute como usuário 'tableau': sudo -u tableau ./backup_tableau.sh

# Configurações
BACKUP_DIR="/var/opt/tableau/tableau_server/data/tabsvc/files/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
CONFIG_FILE="tableau_config_${TIMESTAMP}.json"
DATA_FILE="tableau_data_${TIMESTAMP}.tsbak"
LOG_FILE="/var/log/tableau_backup_${TIMESTAMP}.log"

# Função para log
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a "$LOG_FILE"
}

# Verificar usuário
if [ "$(whoami)" != "tableau" ]; then
    log "ERRO: Deve executar como usuário 'tableau'. Use 'sudo -u tableau $0'."
    exit 1
fi

# Verificar espaço em disco (mínimo 10GB)
FREE_SPACE=$(df -h "$BACKUP_DIR" | awk 'NR==2 {print $4}' | sed 's/G//')
if [ "${FREE_SPACE%.*}" -lt 10 ]; then
    log "ERRO: Espaço insuficiente em $BACKUP_DIR. Livre: $FREE_SPACE GB."
    exit 1
fi

log "Iniciando backup do Tableau Server..."

# Exportar configurações
tsm settings export -f "$BACKUP_DIR/$CONFIG_FILE" >> "$LOG_FILE" 2>&1
if [ $? -eq 0 ]; then
    log "Export de configurações concluído: $CONFIG_FILE"
else
    log "ERRO: Falha no export de configurações."
    exit 1
fi

# Backup dos dados
tsm maintenance backup -f "$DATA_FILE" -d >> "$LOG_FILE" 2>&1
if [ $? -eq 0 ]; then
    log "Backup de dados concluído: $DATA_FILE"
else
    log "ERRO: Falha no backup de dados."
    exit 1
fi

log "Backup completo. Arquivos em $BACKUP_DIR, log em $LOG_FILE."
log "Documente ativos manuais (ex.: contas, certificados) fora do TSM."

