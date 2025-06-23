#!/bin/bash

set -e

echo "📦 Installation de dev-assist..."

DEST="/usr/local/bin/dev-assist"
TMP_FILE="/tmp/dev-assist.sh"

curl -fsSL https://raw.githubusercontent.com/tomtomysteria/dev-assist/main/dev-assist.sh -o "$TMP_FILE"
mv "$TMP_FILE" "$DEST"
chmod +x "$DEST"

echo "✅ dev-assist est maintenant disponible en tant que commande globale"
echo "➡️  Utilise : dev-assist"
