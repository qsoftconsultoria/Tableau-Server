# Tableau Server

Bem-vindo ao repositório da QSOFT
Este repositório contém scripts e documentação para automatizar e facilitar essas tarefas.

## Estrutura do Repositório
- `backup/`: Contém scripts Bash para automação.
  - `backup_tableau.sh`: Script para backup de configurações e dados do Tableau Server.
  - `backup_guide.md`: Instruções para configurar e executar backups.
- `Linux/`: Contém scripts Bash para automação.  
  - `install_fonts.sh`: Script para instalar fontes TTF/OTF no RHEL 9.7.
  - `fonts_install_guide.md`: Passos para instalar fontes no sistema.

## Como Usar
1. **Clone o repositório**:
   ```bash
   git clone https://github.com/qsoft/tableau-cliente-backup-fontes.git
   cd tableau-cliente-backup-fontes
   ```
2. **Scripts**:
   - Execute `chmod +x scripts/*.sh` para tornar os scripts executáveis.
   - Veja detalhes em `docs/backup_guide.md` e `docs/fonts_install_guide.md`.
3. **Backup**:
   - Rode `./scripts/backup_tableau.sh` como usuário `tableau`.
   - Verifique os logs e arquivos gerados em `/var/opt/tableau/tableau_server/data/tabsvc/files/backups`.
4. **Instalação de fontes**:
   - Copie suas fontes para um diretório acessível.
   - Rode `sudo ./scripts/install_fonts.sh` e siga as instruções em `docs/fonts_install_guide.md`.

## Notas
- Teste os scripts em um ambiente de desenvolvimento antes de usar em produção.
- Mantenha backups dos arquivos de fonte e configurações em local seguro.