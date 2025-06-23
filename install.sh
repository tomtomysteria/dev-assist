#!/bin/bash

set -e

echo "📦 Installation de dev-assist..."

DEST="/usr/local/bin/dev-assist"
TMP_FILE="/tmp/dev-assist.sh"

curl -fsSL https://raw.githubusercontent.com/<ton-utilisateur>/<ton-repo>/main/dev-assist.sh -o "$TMP_FILE"
sudo mv "$TMP_FILE" "$DEST"
sudo chmod +x "$DEST"

echo "✅ dev-assist est maintenant disponible en tant que commande globale"
echo "➡️  Utilise : dev-assist"
