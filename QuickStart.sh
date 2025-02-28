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
  echo "Gum is not install, please install Gum"
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

project_name_formated=""
docs_link=""

while true; do
  project_category=$(choose "📂 Select a project category:" "Website" "Mobile App" "Desktop App" "Other")

  while true; do
    case $project_category in
    "Website")
      project_type=$(choose "💡 Choose your stack:" "HTML, CSS, JS" "Node.js" "Next.js" "Python" "Go Back" "Exit")
      ;;
    "Mobile App")
      project_type=$(choose "📱 Choose your framework:" "React Native" "Flutter" "Swift" "Kotlin" "Go Back" "Exit")
      ;;
    "Desktop App")
      project_type=$(choose "🖥️ Choose your stack:" "Electron.js" "Tauri" "Python (PyQt)" "C++ (Qt)" "Go Back" "Exit")
      ;;
    "Other")
      project_type=$(choose "🛠️ Other options:" "Bash" "C" "C++" "Rust" "Go Back" "Exit")
      ;;
    esac

    if [ "$project_type" == "Go Back" ]; then
      break # Retour à la sélection de la catégorie
    elif [ -n "$project_type" ]; then
      break 2 # Sort complètement des boucles si un choix est validé
    fi
  done
done

# Vérifier si l'utilisateur a choisi de quitter
if [ "$project_type" == "Exit" ]; then
  echo "❌ Cancelation."
  exit 0
fi

use_git=$(choose "🛠️ Use Git" "Yes" "No")

if [[ "$project_name" =~ \ |\' ]]; then #  slightly more readable: if [[ "$string" =~ ( |\') ]]
  project_name_formated="${project_name// /_}"
else
  project_name_formated="$project_name"
fi

mkdir -p "$project_name_formated" && cd "$project_name_formated" || exit 1

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
  echo "🚀 HTML project created in $project_name_formated/"
  docs_link="https://developer.mozilla.org/fr/docs/Web/HTML"
  ;;

"Python")
  touch main.py
  echo "# $project_name" >README.md
  echo "print('Hello, $project_name!')" >main.py
  echo "🚀 Python project created in $project_name_formated/"
  docs_link="https://docs.python.org/3/"
  ;;

"Node.js")
  node_package_manager_choice=$(choose "Which Package Manager would you use ?" "NPM" "PNPM" "Yarn")
  if [ "$node_package_manager_choice" == "NPM" ]; then
    node_package_manager="npm"
  elif [ "$node_package_manager_choice" == "PNPM" ]; then
    node_package_manager="pnpm"
  elif [ "$node_package_manager_choice" == "Yarn" ]; then
    node_package_manager="yarn"
  fi

  if [ "$node_package_manager" == "npm" ]; then
    $node_package_manager init -y # Ajout de l'option -y pour l'initialisation avec npm
  elif [ "$node_package_manager" == "pnpm" ]; then
    $node_package_manager init # Pas de -y avec pnpm, on laisse l'init sans options
  else
    $node_package_manager init -y # Utilisation de l'option -y pour Yarn aussi
  fi

  clear
  use_eslint=$(choose "Use ESLint ?" "Yes" "No")
  if [ "$use_eslint" == "Yes" ]; then
    $node_package_manager install eslint --save-dev
    $node_package_manager eslint --init
  fi
  echo "console.log('Hello, $project_name!');" >index.js
  echo "🚀 Node.js project created in $project_name_formated/"
  docs_link="https://nodejs.org/docs/latest/api/"
  ;;

"Next.js")
  node_package_manager_choice=$(choose "Which Package Manager would you use ?" "NPM" "PNPM" "Yarn")
  if [ "$node_package_manager_choice" == "NPM" ]; then
    node_package_manager="npm"
  elif [ "$node_package_manager_choice" == "PNPM" ]; then
    node_package_manager="pnpm"
  elif [ "$node_package_manager_choice" == "Yarn" ]; then
    node_package_manager="yarn"
  fi

  if [ "$node_package_manager" == "npm" ]; then
    $node_package_manager init -y # Ajout de l'option -y pour l'initialisation avec npm
  elif [ "$node_package_manager" == "pnpm" ]; then
    $node_package_manager init # Pas de -y avec pnpm, on laisse l'init sans options
  else
    $node_package_manager init -y # Utilisation de l'option -y pour Yarn aussi
  fi

  $node_package_manager install react react-dom next
  clear
  echo "{
    \"scripts\": {
      \"dev\": \"next dev\",
      \"build\": \"next build\",
      \"start\": \"next start\"
    }
  }" >package.json
  mkdir pages
  echo "import React from 'react';
  
  export default function Home() {
    return <h1>Welcome to $project_name with Next.js!</h1>;
  }" >pages/index.js
  echo "🚀 Next.js project created in $project_name_formated/"
  docs_link="https://nextjs.org/docs"
  ;;

"Bash")
  touch script.sh
  chmod +x script.sh
  echo "#!/bin/bash" >script.sh
  echo 'echo "Hello, $project_name!"' >>script.sh
  echo "🚀 Bash project created in $project_name_formated/"
  docs_link="https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html"
  ;;

"C")
  touch main.c
  echo "#include <stdio.h>

int main() {
    printf(\"Hello, $project_name!\\n\");
    return 0;
}" >main.c
  echo "🚀 C project created in $project_name_formated/"
  docs_link="https://devdocs.io/c/"
  ;;

"C++")
  touch main.cpp
  echo "#include <iostream>

int main() {
    std::cout << \"Hello, $project_name!\" << std::endl;
    return 0;
}" >main.cpp
  echo "🚀 C++ project created in $project_name_formated/"
  docs_link="https://devdocs.io/cpp/"
  ;;

"Rust")
  if command -v cargo &>/dev/null; then
    cargo init --name "$project_name"
    echo "🚀 Rust project created with Cargo in $project_name_formated/"
    docs_link="https://doc.rust-lang.org/beta/"
  else
    echo "❌ Cargo is not installed. Install it before creating a Rust project."
  fi
  ;;
"Electron.js")
  mkdir -p "$project_name_formated" && cd "$project_name_formated" || exit 1
  npm init -y
  npm install electron --save-dev
  echo "🚀 Electron.js project created in $project_name_formated/"
  docs_link="https://www.electronjs.org/fr/docs/latest/"
  ;;

"Tauri")
  mkdir -p "$project_name_formated" && cd "$project_name_formated" || exit 1
  npm init -y
  npm install tauri --save-dev
  echo "🚀 Tauri project created in $project_name_formated/"
  docs_link="https://v1.tauri.app/fr/v1/guides/"
  ;;

"Python (PyQt)")
  mkdir -p "$project_name_formated" && cd "$project_name_formated" || exit 1
  python3 -m venv venv
  source venv/bin/activate
  pip install pyqt5
  touch main.py
  echo "from PyQt5.QtWidgets import QApplication, QWidget

app = QApplication([])
window = QWidget()
window.setWindowTitle('$project_name')
window.show()
app.exec_()" >main.py
  echo "🚀 Python (PyQt) project created in $project_name_formated/"
  docs_link="https://docs.python.org/3/"
  ;;

"C++ (Qt)")
  mkdir -p "$project_name_formated" && cd "$project_name_formated" || exit 1
  touch main.cpp
  echo "#include <QApplication>
#include <QWidget>

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
    QWidget window;
    window.setWindowTitle(\"$project_name\");
    window.show();
    return app.exec();
}" >main.cpp
  echo "🚀 C++ (Qt) project created in $project_name_formated/"
  docs_link="https://devdocs.io/cpp/"
  ;;
"React Native")
  node_package_manager_choice=$(choose "Which Package Manager would you use ?" "NPM" "PNPM" "Yarn")
  if [ "$node_package_manager_choice" == "NPM" ]; then
    node_package_manager="npm"
  elif [ "$node_package_manager_choice" == "PNPM" ]; then
    node_package_manager="pnpm"
  elif [ "$node_package_manager_choice" == "Yarn" ]; then
    node_package_manager="yarn"
  fi

  if [ "$SYSTEM" == "macOS" ]; then
    echo "🚀 Creating a React Native project for macOS"
    if [ "$node_package_manager" == "pnpm" ]; then
      pnpm dlx @react-native-community/cli init "$project_name"
    else
      npx @react-native-community/cli init "$project_name"
    fi
  else
    echo "🚨 React Native requires macOS for iOS development. You can create an Android project instead."
    npx @react-native-community/cli init "$project_name" --template react-native-template-typescript
  fi
  echo "🚀 React Native project created in $project_name_formated/"
  docs_link="https://reactnative.dev/docs/getting-started"
  ;;

"Flutter")
  if command -v flutter &>/dev/null; then
    flutter create "$project_name"
    echo "🚀 Flutter project created in $project_name_formated/"
    docs_link="https://docs.flutter.dev/"
  else
    echo "❌ Flutter is not installed. Please install Flutter SDK first."
  fi
  ;;

"Swift")
  if [ "$SYSTEM" == "macOS" ]; then
    mkdir -p "$project_name_formated" && cd "$project_name_formated" || exit 1
    echo "import Foundation

print(\"Hello, $project_name!\")" >main.swift
    swiftc main.swift -o "$project_name"
    echo "🚀 Swift project created in $project_name_formated/"
    docs_link="https://www.swift.org/documentation/"
  else
    echo "❌ Swift can only be run on macOS."
  fi
  ;;

"Kotlin")
  mkdir -p "$project_name_formated" && cd "$project_name_formated" || exit 1
  touch Main.kt
  echo "fun main() {
    println(\"Hello, $project_name!\")
}" >Main.kt
  echo "🚀 Kotlin project created in $project_name_formated/"
  docs_link="https://kotlinlang.org/docs/home.html"
  ;;

*)
  echo "❌ Unknown project type."
  exit 1
  ;;
esac

echo "📄 You can find Docs here: $(tput bold)$docs_link$(tput sgr0)"
echo "👉 To enter your project directory, run: $(tput bold)cd $project_name_formated$(tput sgr0)"
