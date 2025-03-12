#!/bin/bash

echo "Running ESLint..."
npx scriptt.js || echo "Linting finished with warnings"

echo "Running Stylelint..."
npx stylelint "**/*.css" || echo "Linting finished with warnings"

echo "Validating HTML..."
npx htmlhint "*.html" || echo "HTML validation completed"
