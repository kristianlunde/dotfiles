#!/usr/bin/env bash

sudo dnf install evolution adwaita-qt adwaita-icon-theme


# Install Inter font if available in your distro
if command -v sudo &>/dev/null; then
    if command -v apt &>/dev/null; then
        sudo apt install fonts-inter -y
    elif command -v dnf &>/dev/null; then
        sudo dnf install google-inter-fonts -y
    elif command -v pacman &>/dev/null; then
        sudo pacman -S inter-font --noconfirm
    fi
fi

echo "Applying partial macOS Mail style settings..."

# Force light theme for Evolution
mkdir -p ~/.local/share/applications
cp /usr/share/applications/org.gnome.Evolution.desktop ~/.local/share/applications/ 2>/dev/null || true
sed -i 's|Exec=evolution|Exec=env GTK_THEME=Adwaita:light evolution|' ~/.local/share/applications/org.gnome.Evolution.desktop

# Pick font
FONT="Inter 13"
if ! fc-list | grep -qi "Inter"; then
    FONT="Cantarell 13"
fi
gsettings set org.gnome.desktop.interface document-font-name "$FONT"

# Hide grid lines where possible
gsettings set org.gnome.evolution.mail.thread-list-show-vertical-lines false || true
gsettings set org.gnome.evolution.mail.thread-list-show-horizontal-lines false || true

# Slightly increase global row spacing (affects message list)
gsettings set org.gnome.evolution.mail.thread-list-cell-spacing 6 || true

mkdir -p ~/.config/gtk-3.0
cat > ~/.config/gtk-3.0/gtk.css <<'EOF'
/* Make Evolution toolbar icons dark on light background */
.header-bar .image,
.toolbar .image,
.primary-toolbar .image {
    color: #2e2e2e;
    -gtk-icon-effect: none;
}
EOF



echo "✅ Light mode + cleaner font + spacing applied."
echo "⚠ Please open Evolution and set the following manually for full macOS look:"
echo "   - View → Layout → Vertical View"
echo "   - View → Group by Threads"
echo "   - Edit → Preferences → Mail Preferences → Enable Snippet View"
echo "   - Right-click Toolbar → Customize Toolbar → Keep only essential icons"

