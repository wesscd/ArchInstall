#!/bin/bash

# Script pós-instalação para Arch Linux com GNOME
# Otimiza o sistema e adiciona vibe "hacker"
# Execute como root (sudo -i) ou com sudo

echo "Iniciando configuração pós-instalação do Arch Linux..."

# Atualizar o sistema
echo "Atualizando o sistema..."
pacman -Syu --noconfirm

# Instalar pacotes essenciais e ferramentas "hacker"
echo "Instalando pacotes essenciais..."
pacman -S --noconfirm \
    kitty neofetch htop btop \
    ttf-fira-code ttf-jetbrains-mono \
    gnome-tweaks gnome-shell-extensions \
    gnome-browser-connector \
    papirus-icon-theme arc-gtk-theme \
    nitrogen \
    base-devel git vim zsh

# Configurar TRIM para SSD (se aplicável)
if lsblk -d -o rota | grep -q 0; then
    echo "Ativando TRIM para SSD..."
    systemctl enable fstrim.timer
    systemctl start fstrim.timer
else
    echo "Nenhum SSD detectado, pulando configuração de TRIM."
fi

# Otimizar pacman (ativar downloads paralelos)
echo "Otimizando pacman..."
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf

# Instalar yay (AUR helper)
echo "Instalando yay (AUR helper)..."
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Instalar temas e extensões via AUR
echo "Instalando temas e extensões..."
yay -S --noconfirm \
    orchis-theme \
    gnome-shell-extension-dash-to-dock

# Configurar ZSH como shell padrão
echo "Configurando ZSH..."
chsh -s /bin/zsh
curl -L https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

# Configurar tema dark no GNOME
echo "Aplicando tema dark..."
gsettings set org.gnome.desktop.interface gtk-theme 'Orchis-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Otimizar performance do GNOME
echo "Otimizando GNOME..."
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.interface enable-animations false

# Configurar neofetch para rodar no terminal
echo "Configurando neofetch..."
mkdir -p ~/.config/neofetch
echo "neofetch" >> ~/.zshrc

# Adicionar alias úteis
echo "Adicionando alias úteis ao .zshrc..."
cat <<EOL >> ~/.zshrc
alias update='sudo pacman -Syu'
alias clean='sudo pacman -Rns \$(pacman -Qtdq)'
alias ll='ls -la'
alias gs='git status'
EOL

# Configurar wallpaper dinâmico com nitrogen
echo "Configurando nitrogen..."
mkdir -p ~/Wallpapers
nitrogen --set-zoom-fill --random ~/Wallpapers

# Finalização
echo "Configuração concluída! Reinicie o sistema para aplicar todas as mudanças."
echo "Para personalizar ainda mais, use 'gnome-tweaks' e explore os temas!"
