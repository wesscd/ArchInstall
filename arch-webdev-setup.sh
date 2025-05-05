#!/bin/bash

# Script para configurar ambiente de desenvolvimento web no Arch Linux
# Inclui GitHub, Docker, VS Code e ferramentas para dev web
# Execute como root (sudo -i) ou com sudo

echo "Configurando ambiente de desenvolvimento web..."

# Atualizar o sistema
echo "Atualizando o sistema..."
pacman -Syu --noconfirm

# Instalar ferramentas de desenvolvimento web
echo "Instalando Node.js, npm, VS Code, Git e dependências..."
pacman -S --noconfirm \
    nodejs npm \
    code \
    git

# Instalar Docker e Docker Compose
echo "Instalando Docker e Docker Compose..."
pacman -S --noconfirm docker docker-compose
systemctl enable docker
systemctl start docker
usermod -aG docker $SUDO_USER

# Instalar GitHub Desktop via AUR
echo "Instalando GitHub Desktop..."
yay -S --noconfirm github-desktop

# Configurar Git
echo "Configurando Git..."
git config --global user.name "$SUDO_USER"
git config --global user.email "$SUDO_USER@example.com"
git config --global core.editor "code --wait"
git config --global init.defaultBranch main

# Instalar extensões recomendadas pro VS Code
echo "Instalando extensões do VS Code..."
sudo -u $SUDO_USER code --install-extension esbenp.prettier-vscode
sudo -u $SUDO_USER code --install-extension dbaeumer.vscode-eslint
sudo -u $SUDO_USER code --install-extension ms-vscode.vscode-typescript-next
sudo -u $SUDO_USER code --install-extension bradlc.vscode-tailwindcss
sudo -u $SUDO_USER code --install-extension github.vscode-github-actions

# Adicionar aliases úteis pro desenvolvimento
echo "Adicionando aliases ao .zshrc..."
cat <<EOL >> /home/$SUDO_USER/.zshrc
alias dc='docker-compose'
alias dcup='docker-compose up -d'
alias dcdown='docker-compose down'
alias gs='git status'
alias gp='git push'
alias gpl='git pull'
alias npmi='npm install'
alias nr='npm run'
EOL

# Configurar auto-indentação no VS Code
echo "Configurando auto-indentação no VS Code..."
mkdir -p /home/$SUDO_USER/.config/Code/User
cat <<EOL > /home/$SUDO_USER/.config/Code/User/settings.json
{
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.tabSize": 2,
    "editor.autoIndent": "full"
}
EOL
chown $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.config/Code/User/settings.json

# Finalização
echo "Configuração concluída! Reinicie o terminal ou o sistema para aplicar as mudanças."
echo "Edite o email do Git com 'git config --global user.email seu@email.com'."
echo "Para começar, abra o GitHub Desktop ou use 'code' para abrir o VS Code!"
