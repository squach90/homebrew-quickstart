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
fi

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
project_name=$(ask "Nom du projet")
[ -z "$project_name" ] && echo "⚠️ Nom du projet requis !" && exit 1

# Choisir le type de projet
project_type=$(choose "💡 Quel type de projet veux-tu créer ?" "HTML, CSS, JS" "Python" "Node.js" "Bash" "C" "C++" "Rust" "Quitter")

# Vérifier si l'utilisateur a choisi de quitter
if [ "$project_type" == "Quitter" ]; then
  echo "Annulation."
  exit 0
fi

use_git=$(choose "🛠️ Utiliser Git" "Yes" "No")

# Créer le dossier du projet
mkdir -p "$project_name"
cd "$project_name" || exit 1
$([ "$use_git" == "Yes" ] && git init --quiet)

# Initialiser les fichiers selon le type de projet
case $project_type in
"HTML, CSS, JS")
  use_tailwind=$(choose "🎨 Utiliser Tailwind CSS?" "Yes" "No")
  echo "<!DOCTYPE html>
<html>
<head>
    <title>$project_name</title>
    $([ "$use_tailwind" == "Yes" ] && echo '<script src="https://cdn.tailwindcss.com"></script>')
    <link rel='stylesheet' href='styles.css'>
    <script src='app.js'></script>
</head>
<body>
    <h1>Bienvenue sur $project_name</h1>
</body>
</html>" >index.html
  echo 'console.log("QuickStart was here")' >app.js
  echo "body {color: red}" >styles.css
  echo "🚀 Projet HTML créé dans $project_name/"
  ;;

"Python")
  touch main.py
  echo "# $project_name" >README.md
  echo "print('Hello, $project_name!')" >main.py
  echo "🚀 Projet Python créé dans $project_name/"
  ;;

"Node.js")
  npm init -y
  use_eslint=$(choose "Utiliser ESLint?" "Yes" "No")
  if [ "$use_eslint" == "Yes" ]; then
    npm install eslint --save-dev
    npx eslint --init
  fi
  echo "console.log('Hello, $project_name!');" >index.js
  echo "🚀 Projet Node.js créé dans $project_name/"
  ;;

"Bash")
  touch script.sh
  chmod +x script.sh
  echo "#!/bin/bash" >script.sh
  echo 'echo "Hello, $project_name!"' >>script.sh
  echo "🚀 Projet Bash créé dans $project_name/"
  ;;

"C")
  touch main.c
  echo "#include <stdio.h>

int main() {
    printf(\"Hello, $project_name!\\n\");
    return 0;
}" >main.c
  echo "🚀 Projet C créé dans $project_name/"
  ;;

"C++")
  touch main.cpp
  echo "#include <iostream>

int main() {
    std::cout << \"Hello, $project_name!\" << std::endl;
    return 0;
}" >main.cpp
  echo "🚀 Projet C++ créé dans $project_name/"
  ;;

"Rust")
  if command -v cargo &>/dev/null; then
    cargo init --name "$project_name"
    echo "🚀 Projet Rust créé avec Cargo dans $project_name/"
  else
    echo "❌ Cargo n'est pas installé. Installe-le avant de créer un projet Rust."
  fi
  ;;
esac

echo "🎉 Projet $project_name prêt sur $SYSTEM !"
