[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

function todo() {
  todos=$(todo.sh list | grep -o "^[0-9].*" | sort)
  items=($todos "+")
  command=$(printf "%s\n" "${items[@]}" | fzf --prompt=" TODOs  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $command ]]; then
    echo "TODO not selected"
    return 0
  elif [[ $command == "+" ]]; then
    todo.sh add "$(gum input --placeholder="TODO")"
  else
    opts=("done" "delete")
    option=$(printf "%s\n" "${opts[@]}" | fzf --prompt="What to do with TODO $command?" --height=~50% --border)
    if [[ $option == "delete" ]]; then
      todo.sh del "$(echo "$command" | grep -o "^[0-9]")"
    elif [[ $option == "done" ]]; then
      todo.sh done "$(echo "$command" | grep -o "^[0-9]")"
    fi

    echo "$option"
  fi
}
