#!/bin/bash

echo "Running ESLint..."

# Check if ESLint is installed, if not, install it
if ! [ -x "$(command -v eslint)" ]; then
  echo "ESLint is not installed. Installing..."
  npm install -g eslint
fi

# Run ESLint
eslint . --ext .js,.jsx,.ts,.tsx

if [ $? -ne 0 ]; then
  echo "ESLint found issues!"
else
  echo "ESLint check passed!"
fi

echo "Running Stylelint..."

# Check if Stylelint is installed, if not, install it
if ! [ -x "$(command -v stylelint)" ]; then
  echo "Stylelint is not installed. Installing..."
  npm install -g stylelint stylelint-config-standard
fi

# Run Stylelint
stylelint "**/*.css"

if [ $? -ne 0 ]; then
  echo "Stylelint found issues!"
else
  echo "Stylelint check passed!"
fi

echo "Linting completed!"
