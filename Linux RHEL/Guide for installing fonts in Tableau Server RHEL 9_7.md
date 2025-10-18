

# Guia de Instalação de Fontes no Tableau Server (RHEL 9.7)

Este guia explica como instalar fontes TTF/OTF no RHEL 9.7 para uso no Tableau Server com o script `install_fonts.sh`.

## Pré-requisitos
- Fontes TTF ou OTF licenciadas em um diretório acessível (ex.: `/caminho/para/suas-fontes`).
- Pacote `fontconfig` instalado: `sudo dnf install fontconfig`.
- Permissões de root/sudo.
- Tableau Server instalado.

## Como Executar
1. Edite `install_fonts.sh` para ajustar `FONT_SRC` ao diretório com suas fontes.
2. Torne o script executável:
   ```bash
   chmod +x scripts/install_fonts.sh
   ```
3. Execute com sudo:
   ```bash
   sudo ./scripts/install_fonts.sh
   ```
4. Verifique as fontes instaladas:
   ```bash
   fc-list | grep "CustomFonts"
   ```

## Notas
- Fontes são instaladas em `/usr/share/fonts/CustomFonts`.
- O script reinicia o Tableau Server automaticamente (`tsm restart`).
- Para multi-node, execute em todos os nós.
- Teste criando uma visualização no Tableau com a fonte instalada.
- Se as fontes não aparecerem, verifique logs (`tsm status -v`) ou reinicie apenas o `vizqlserver`.

