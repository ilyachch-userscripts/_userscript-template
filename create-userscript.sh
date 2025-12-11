#!/bin/bash

if [ ! -d "_userscript-template" ]; then
    echo "This script must be run from the directory containing _userscript-template"
    exit 1
fi

if ! command -v gh &> /dev/null
then
    echo "gh cli could not be found, please install it first."
    exit
fi

if ! command -v cookiecutter &> /dev/null
then
    echo "cookiecutter could not be found, please install it first."
    exit
fi

echo "Enter the name of your userscript project:"
read PROJECT_NAME

PROJECT_SLUG=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

echo "Creating GitHub repository 'ilyachch-userscripts/$PROJECT_SLUG'..."

gh repo create ilyachch-userscripts/$PROJECT_SLUG --public --clone --add-readme --disable-wiki --license MIT || { echo "Repository creation failed. It may already exist."; exit 1; }

cookiecutter -f _userscript-template/ --no-input project_name="$PROJECT_NAME"

cd "$PROJECT_SLUG"

git commit -am "Initial commit - Created userscript project $PROJECT_NAME"

echo "Userscript project '$PROJECT_NAME' created and initialized in the 'ilyachch-userscripts' GitHub repository."
