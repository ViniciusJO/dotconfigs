#!/bin/bash

# ===========================
# 📁 Configurações iniciais
# ===========================

if [ $# -ne 1 ]; then
  echo "Uso: $0 arquivo_de_cores.txt"
  exit 1
fi

INPUT_FILE="$1"

# Verifica se o arquivo existe
if [ ! -f "$INPUT_FILE" ]; then
  echo "Arquivo $INPUT_FILE não encontrado."
  exit 1
fi

# ===========================
# 🎨 Lendo as 6 cores
# ===========================

mapfile -t COLORS < "$INPUT_FILE"

if [ ${#COLORS[@]} -lt 6 ]; then
  echo "O arquivo deve conter pelomenos 6 linhas com cores."
  exit 1
fi

# Função para converter rgba para hex
rgba_to_hex() {
  local arr=($1)
  printf "#%02x%02x%02x" "${arr[0]}" "${arr[1]}" "${arr[2]}"
}

# Convertendo cada cor
HEX_COLORS=()
for c in "${COLORS[@]}"; do
  HEX_COLORS+=("$(rgba_to_hex "$c")")
done

BG="${HEX_COLORS[0]}"
FG="${HEX_COLORS[1]}"
ACCENT1="${HEX_COLORS[2]}"
ACCENT2="${HEX_COLORS[3]}"
ACCENT3="${HEX_COLORS[4]}"
ACCENT4="${HEX_COLORS[5]}"

echo "Cores convertidas:"
echo "BG=$BG FG=$FG ACC1=$ACCENT1 ACC2=$ACCENT2 ACC3=$ACCENT3 ACC4=$ACCENT4"

# ===========================
# 🖌 Gerando tema GTK
# ===========================

THEME_NAME="GeneratedTheme"
GTK_DIR="$HOME/.themes/$THEME_NAME/gtk-3.0"

mkdir -p "$GTK_DIR"

cat <<EOF > "$GTK_DIR/gtk.css"
/* Generated GTK theme */

@define-color bg_color $BG;
@define-color fg_color $FG;
@define-color accent1 $ACCENT1;
@define-color accent2 $ACCENT2;
@define-color accent3 $ACCENT3;
@define-color accent4 $ACCENT4;

window {
  background-color: @bg_color;
  color: @fg_color;
}

button {
  background-color: @accent1;
  color: @fg_color;
}

entry {
  background-color: @accent2;
  color: @fg_color;
}
EOF

# Criando settings.ini
GTK_SETTINGS="$HOME/.config/gtk-3.0/settings.ini"
mkdir -p "$(dirname "$GTK_SETTINGS")"

cat <<EOF > "$GTK_SETTINGS"
[Settings]
gtk-theme-name=$THEME_NAME
gtk-icon-theme-name=Papirus
gtk-font-name=Noto Sans 10
gtk-cursor-theme-name=Breeze
gtk-cursor-theme-size=24
EOF

echo "Tema GTK gerado em $GTK_DIR"

# ===========================
# 🎨 Gerando colorscheme Qt
# ===========================

COLORSCHEME="$HOME/.config/$THEME_NAME.conf"

cat <<EOF > "$COLORSCHEME"
[ColorScheme]
active_background=$BG
active_foreground=$FG
inactive_background=$ACCENT3
inactive_foreground=$ACCENT4
accent=$ACCENT1
EOF

echo "Colorscheme Qt gerado em $COLORSCHEME"

# ===========================
# ⚙️ Gerando qt5ct.conf
# ===========================

QT5CT_CONF="$HOME/.config/qt5ct/qt5ct.conf"
mkdir -p "$(dirname "$QT5CT_CONF")"

cat <<EOF > "$QT5CT_CONF"
[Appearance]
color_scheme_path=$COLORSCHEME
icon_theme=Papirus
standard_dialogs=default

[Fonts]
general="Noto Sans,10,-1,5,50,0,0,0,0,0"
fixed="Hack,10,-1,5,50,0,0,0,0,0"
EOF

echo "qt5ct.conf gerado em $QT5CT_CONF"

# ===========================
# ⚙️ Gerando qt6ct.conf
# ===========================

QT6CT_CONF="$HOME/.config/qt6ct/qt6ct.conf"
mkdir -p "$(dirname "$QT6CT_CONF")"

cat <<EOF > "$QT6CT_CONF"
[Appearance]
color_scheme_path=$COLORSCHEME
icon_theme=Papirus
standard_dialogs=default

[Fonts]
general="Noto Sans,10,-1,5,50,0,0,0,0,0"
fixed="Hack,10,-1,5,50,0,0,0,0,0"
EOF

echo "qt6ct.conf gerado em $QT6CT_CONF"

# ===========================
# ✅ Finalização
# ===========================

echo "Tema GTK e Qt gerados com sucesso."

