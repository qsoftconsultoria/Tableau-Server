

#!/bin/bash

# Script para instalar fontes TTF/OTF no RHEL 9.7 para Tableau Server
# Execute com sudo: sudo ./install_fonts.sh

# Configurações
FONT_DIR="/usr/share/fonts/CustomFonts"
FONT_SRC="/caminho/para/suas-fontes"  # Ajuste para o diretório com suas fontes TTF/OTF

# Verificar se rodando como root
if [ "$(whoami)" != "root" ]; then
    echo "ERRO: Execute com sudo."
    exit 1
fi

# Criar diretório de fontes
mkdir -p "$FONT_DIR"
if [ $? -ne 0 ]; then
    echo "ERRO: Falha ao criar $FONT_DIR."
    exit 1
fi

# Copiar fontes
cp "$FONT_SRC"/*.ttf "$FONT_SRC"/*.otf "$FONT_DIR/" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "Fontes copiadas para $FONT_DIR."
else
    echo "ERRO: Nenhuma fonte TTF/OTF encontrada em $FONT_SRC."
    exit 1
fi

# Ajustar permissões
chmod 644 "$FONT_DIR"/* 2>/dev/null

# Atualizar cache de fontes
fc-cache -f -v
if [ $? -eq 0 ]; then
    echo "Cache de fontes atualizado."
else
    echo "ERRO: Falha ao atualizar cache de fontes."
    exit 1
fi

# Verificar fontes instaladas
echo "Verificando fontes instaladas:"
fc-list | grep "$FONT_DIR"

# Reiniciar Tableau Server
echo "Reiniciando Tableau Server..."
tsm restart
if [ $? -eq 0 ]; then
    echo "Tableau Server reiniciado."
else
    echo "ERRO: Falha ao reiniciar Tableau Server."
    exit 1
fi

echo "Instalação de fontes concluída. Teste no Tableau Server."

