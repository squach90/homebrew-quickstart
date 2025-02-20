#!/bin/bash

# Détection du système
OS=$(uname -s)
case "$OS" in
Linux*) SYSTEM="Linux" ;;
Darwin*) SYSTEM="macOS" ;;
CYGWIN* | MINGW* | MSYS*) SYSTEM="Windows" ;;
*) SYSTEM="Unknown" ;;
esac

# Vérifier si gum est installé
if command -v gum &>/dev/null; then
  HAS_GUM=true
else
  HAS_GUM=false
  echo "Install dependencies: Gum"
  brew install --quiet gum
  echo "Dependencies are being installed, please wait..."
  exec "$0"
fi

clear

# Fonction pour poser une question avec gum si dispo, sinon en ligne de commande
ask() {
  local prompt=$1
  local default=$2
  if [ "$HAS_GUM" = true ]; then
    gum input --placeholder "$prompt"
  else
    read -p "$prompt: " response
    echo "${response:-$default}"
  fi
}

# Fonction pour choisir une option
choose() {
  local prompt=$1
  shift
  local options=("$@")

  if [ "$HAS_GUM" = true ]; then
    gum choose "${options[@]}" --header "$prompt"
  else
    echo "$prompt"
    select opt in "${options[@]}"; do
      if [ -n "$opt" ]; then
        echo "$opt"
        break
      fi
    done
  fi
}

# Demander le nom du projet
project_name=$(ask "Project name")
[ -z "$project_name" ] && echo "⚠️ Project name required !" && exit 1

# Choisir le type de projet
project_type=$(choose "💡 What type of project do you want to create?" "HTML, CSS, JS" "Python" "Node.js" "Bash" "C" "C++" "Rust" "Exit")

# Vérifier si l'utilisateur a choisi de quitter
if [ "$project_type" == "Exit" ]; then
  echo "Cancelation."
  exit 0
fi

use_git=$(choose "🛠️ Use Git" "Yes" "No")

mkdir -p "$project_name" && cd "$project_name" || exit 1

$([ "$use_git" == "Yes" ] && git init --quiet)

# Initialiser les fichiers selon le type de projet
case $project_type in
"HTML, CSS, JS")
  use_tailwind=$(choose "🎨 Use Tailwind CSS?" "Yes" "No")
  echo "<!DOCTYPE html>
<html>
<head>
    <title>$project_name</title>
    $([ "$use_tailwind" == "Yes" ] && echo '<script src="https://cdn.tailwindcss.com"></script>')
    <link rel='stylesheet' href='styles.css'>
    <script src='app.js'></script>
</head>
<body>
    <h1>Welcome on $project_name</h1>
</body>
</html>" >index.html
  echo 'console.log("QuickStart was here")' >app.js
  echo "body {color: red}" >styles.css
  echo "🚀 HTML project created in $project_name/"
  ;;

"Python")
  touch main.py
  echo "# $project_name" >README.md
  echo "print('Hello, $project_name!')" >main.py
  echo "🚀 Python project created in $project_name/"
  ;;

"Node.js")
  npm init -y
  use_eslint=$(choose "Use ESLint?" "Yes" "No")
  if [ "$use_eslint" == "Yes" ]; then
    npm install eslint --save-dev
    npx eslint --init
  fi
  echo "console.log('Hello, $project_name!');" >index.js
  echo "🚀 Node.js project created in $project_name/"
  ;;

"Bash")
  touch script.sh
  chmod +x script.sh
  echo "#!/bin/bash" >script.sh
  echo 'echo "Hello, $project_name!"' >>script.sh
  echo "🚀 Bash project created in $project_name/"
  ;;

"C")
  touch main.c
  echo "#include <stdio.h>

int main() {
    printf(\"Hello, $project_name!\\n\");
    return 0;
}" >main.c
  echo "🚀 C project created in $project_name/"
  ;;

"C++")
  touch main.cpp
  echo "#include <iostream>

int main() {
    std::cout << \"Hello, $project_name!\" << std::endl;
    return 0;
}" >main.cpp
  echo "🚀 C++ project created in $project_name/"
  ;;

"Rust")
  if command -v cargo &>/dev/null; then
    cargo init --name "$project_name"
    echo "🚀 Rust project created with Cargo in $project_name/"
  else
    echo "❌ Cargo is not installed. Install it before creating a Rust project."
  fi
  ;;
esac

echo "🎉 $project_name ready in $project_name/ !"
echo "🛠️ This tool was created by squach90"
echo "👉 To enter your project directory, run: $(tput bold)cd $project_name$(tput sgr0)"
