#!/bin/bash

set -e

echo "📦 Installation de dev-assist..."

DEST="$HOME/bin/dev-assist"
TMP_FILE="/tmp/dev-assist.sh"

# Télécharger le fichier
curl -fsSL https://raw.githubusercontent.com/tomtomysteria/dev-assist/main/dev-assist.sh -o "$TMP_FILE"

# Créer le répertoire ~/bin s'il n'existe pas
mkdir -p "$(dirname "$DEST")"

# Déplacer le fichier dans ~/bin
mv "$TMP_FILE" "$DEST"

# Rendre le fichier exécutable
chmod +x "$DEST"

echo "✅ dev-assist est maintenant installé."
echo "📂 Le fichier se trouve ici : $DEST"
echo "⌨️  Pour créer un alias, ajoutez cette ligne à votre ~/.bashrc :"
echo "alias dev-assist='bash $DEST'"
echo "🔁 Rechargez votre shell avec : source ~/.bashrc"
echo "➡️  Utilise : dev-assist"
