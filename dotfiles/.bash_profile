if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  echo "Select session:"
  echo "1. Plasma 6"
  echo "2. Sway"
  read -r choice
  case $choice in
    1) exec dbus-run-session startplasma-wayland ;;
    2) exec sway ;;
    *) echo "Invalid choice"; exit 1 ;;
  esac
fi
