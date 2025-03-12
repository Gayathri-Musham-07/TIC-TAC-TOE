#!/bin/bash

echo "Running ESLint..."
npx eslint script.js || echo "Linting finished with warnings"

echo "Running Stylelint..."
npx stylelint "**/*.css" || echo "Linting finished with warnings"

echo "Validating HTML..."
npx htmlhint "*.html" || echo "HTML validation completed"
