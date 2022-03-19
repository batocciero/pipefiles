#!/bin/bash
# CREATED IN
# March 7 2021

# folder_name; compiled_file; start line;

BLACK="\u001b[30m"
RED="\u001b[1;31m"
GREEN="\u001b[1;32m"
YELLOW="\u001b[1;33m"
BLUE="\u001b[34m"
MAGENTA="\u001b[35m"
CYAN="\u001b[36m"
WHITE="\u001b[37m"
RESET="\u001b[0m"

BUILD_FOLDER="compiled"
BUILD_FILE="auto"
BIN="$BUILD_FOLDER/$BUILD_FILE"
LOCAL_BIN="$HOME/.local/bin"

ALL=(
  "bash/menu.sh"
  "bash/general_installer.sh"
  "bash/general_cmd.sh"
  "bash/Ubuntu/cmd.sh"
  "bash/Ubuntu/apt_install.sh"
  "bash/main.sh"
)

# this is where the builder should start for each file to compile.
START_LINES=(
  0
  2
  2
  2
  2
  20
)

ALL_LENGTH=${#ALL[@]}

build_compile() {
  bash_file=$1
  start_line=$2

  local counter=0

  if [[ ! -d "$BUILD_FOLDER" ]]; then
    mkdir "$BUILD_FOLDER" && touch "$BUILD_FOLDER/$BUILD_FILE"
  fi

  while IFS= read -r line; do
    ((counter = counter + 1))

    if [[ $counter -gt $start_line ]]; then
      # printf '%s\n' "$line"
      echo "$line" >>"$BUILD_FOLDER/$BUILD_FILE"
    fi
  done <"$bash_file"
}

build_all() {
  for ((i = 0; i < "${ALL_LENGTH}"; i++)); do
    build_compile "${ALL[$i]}" "${START_LINES[$i]}"
    echo -e "${GREEN}${ALL[$i]}${RESET} has been compiled."
  done
}

build_gitbash() {
  local gitbash_files=(
    "bash/special_files/gitbash_menu.sh"
    "bash/felib.sh"
    "bash/general_cmd.sh"
    "bash/special_files/gitbash_main.sh"
  )
  local gitbash_lines=(0 9 2 4)
  local gitbash_files_length=${#gitbash_files[@]}

  for ((i = 0; i < "${gitbash_files_length}"; i++)); do
    build_compile "${gitbash_files[i]}" "${gitbash_lines[i]}"
    echo -e "${GREEN}${gitbash_files[i]}${RESET} has been compiled."
  done
}

build_clear() {
  if [[ -d "$BUILD_FOLDER" ]]; then
    rm -rf "$BUILD_FOLDER"
    echo "the $BUILD_FOLDER folder has ben removed. Project cleaned."
  else
    echo "The project is already clean."
  fi
}

install() {
  [[ ! -d "$BUILD_FOLDER" ]] && echo "Please compile it first." \
  && exit 1
  [[ ! -d "$LOCAL_BIN" ]] && mkdir -p "$LOCAL_BIN"
  cp "$BIN" "$LOCAL_BIN" && chmod 777 "$LOCAL_BIN/$BUILD_FILE"\
  && echo -e "${GREEN}The project has been installed at $LOCAL_BIN${RESET}"
}

build_menu() {
  echo ""
  echo -e "${YELLOW}-- 'builder.sh' Will compile all scripts in 'auto' --\
   ${RESET}"
  echo -e "${MAGENTA}-c or -clean${RESET}   |${CYAN} clear the project build\
   folder. ${RESET}"
  echo -e "${MAGENTA}-b -build-all${RESET}  |${CYAN} compile all scripts in \
  only one.${RESET}"
  echo -e "${MAGENTA}-gitbash       ${RESET}|${CYAN} compile the scripts\
   that runs on windows gitbash.${RESET}"
  echo -e "${MAGENTA}-i or -install${RESET} |${CYAN} to install the script\
   on $LOCAL_BIN${RESET}"
  echo ""
}

while [[ "$1" ]]; do
  case "$1" in
  -c | -clean)
    build_clear
    exit 0
    ;;

  -b | -build-all)
    if [[ -d "compiled" ]]; then
      echo "please run -c to clean first."
      exit 1
    fi
    build_all
    exit 0
    ;;

  -gitbash)
    if [[ -d "compiled" ]]; then
      echo "please run -c to clean first."
      exit 1
    fi
    build_gitbash
    exit 0
    ;;

  -i | -install)
    install
    exit 0
    ;;

  -debug)
    [ ! -x "$(command -v docker)" ] \
    && echo "Please install docker first." && exit 1

    docker run --rm -it --entrypoint bash --name test -v \
    "$PWD":/home/test/auto test

    exit 0
    ;;

  esac
done

if [[ -z "${1}" ]]; then
  build_menu
fi
