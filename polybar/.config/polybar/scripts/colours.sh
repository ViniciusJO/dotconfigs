get_color(){
  key="$1"   # ex: pprim
  # config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/polybar"
  config_dir="$HOME/.cache"

  # procura recursivamente por uma linha contendo "pprim" e um = e o hex
  # suporta espaços: pprim = #rrggbb
  # ignora comentários que começam com #
  # find "$config_dir" -type f -name '*' -print0 2>/dev/null |
  # xargs -0 grep -I --line-number -E "^\s*${key}\s*=" 2>/dev/null |
  # head -n1 |
  # sed -E 's/^[^:]+:[0-9]+:\s*//; s/^\s*[^=]+=//; s/[ \t]*#.*$//; s/^[ \t]+|[ \t]+$//'
  cat ~/.cache/dyn_colors.ini | grep $key | sed 's/ //g' | cut -d'=' -f2
}
