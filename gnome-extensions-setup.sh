#!/bin/bash

# Script para instalar e configurar extensões úteis no GNOME
# Execute como usuário normal (não precisa de sudo)

echo "Configurando extensões úteis para o GNOME..."

# Instalar gnome-extensions-app (se não estiver instalado)
if ! pacman -Qs gnome-extensions-app > /dev/null; then
    echo "Instalando gnome-extensions-app..."
    sudo pacman -S --noconfirm gnome-extensions-app
fi

# Instalar extensões via AUR e gnome-extensions
echo "Instalando extensões do GNOME..."
yay -S --noconfirm \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-caffeine \
    gnome-shell-extension-clipboard-indicator \
    gnome-shell-extension-gsconnect \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-user-theme \
    gnome-shell-extension-just-perfection

# Ativar extensões
echo "Ativando extensões..."
gnome-extensions enable appindicator@ubuntu.com
gnome-extensions enable caffeine@patapon.info
gnome-extensions enable clipboard-indicator@tudmotu.com
gnome-extensions enable gsconnect@andyholmes.github.io
gnome-extensions enable blur-my-shell@aunetx
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable just-perfection-desktop@just-perfection

# Configurar Dash to Dock (já instalado anteriormente)
echo "Configurando Dash to Dock..."
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.8

# Configurar Blur my Shell
echo "Configurando Blur my Shell..."
gsettings set org.gnome.shell.extensions.blur-my-shell panel-blur true
gsettings set org.gnome.shell.extensions.blur-my-shell overview-blur true
gsettings set org.gnome.shell.extensions.blur-my-shell appfolder-blur false

# Configurar Just Perfection
echo "Configurando Just Perfection..."
gsettings set org.gnome.shell.extensions.just-perfection startup-status 1
gsettings set org.gnome.shell.extensions.just-perfection desktop-icon false
gsettings set org.gnome.shell.extensions.just-perfection animation 2 # Animações mais rápidas

# Configurar User Themes
echo "Aplicando tema Orchis no shell..."
gsettings set org.gnome.shell.extensions.user-theme name 'Orchis-Dark'

# Finalização
echo "Configuração concluída! Reinicie o GNOME com 'Alt + F2, r' ou reinicie o sistema."
echo "Use 'gnome-extensions-app' para gerenciar extensões ou ajustar configs!"
