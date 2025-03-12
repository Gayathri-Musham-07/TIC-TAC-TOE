#!/bin/bash

echo "Running ESLint..."

# Ensure node_modules/.bin is in PATH
export PATH="./node_modules/.bin:$PATH"

# Check if ESLint is installed locally, if not, install it
if ! [ -x "$(command -v eslint)" ]; then
  echo "Installing ESLint locally..."
  npm install --save-dev eslint
fi

# Run ESLint
npx eslint . --ext .js,.jsx,.ts,.tsx

if [ $? -ne 0 ]; then
  echo "ESLint found issues!"
else
  echo "ESLint check passed!"
fi

echo "Running Stylelint..."

# Check if Stylelint is installed locally, if not, install it
if ! [ -x "$(command -v stylelint)" ]; then
  echo "Installing Stylelint locally..."
  npm install --save-dev stylelint stylelint-config-standard
fi

# Run Stylelint
npx stylelint "**/*.css"

if [ $? -ne 0 ]; then
  echo "Stylelint found issues!"
else
  echo "Stylelint check passed!"
fi

echo "Linting completed!"
