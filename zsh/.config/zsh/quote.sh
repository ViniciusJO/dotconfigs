rndCowFile() {
  find /usr/share/cows | tr "\n" ";" | cut -d';' -f"$(octave --eval "mod($RANDOM,$(find /usr/share/cows | wc -l))+1" --silent | awk '{print $3}')"
}

function rndcowsay() {
  COWFILE="$(rndCowFile)"

  quote | cowsay -f "$COWFILE"
  # echo "$COWFILE"
}
