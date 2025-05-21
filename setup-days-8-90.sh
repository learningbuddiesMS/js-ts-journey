#!/bin/bash

echo "📁 Creating folders and files for days 008-090..."

# Create shared directories if they don't exist
mkdir -p codewars
mkdir -p projects
mkdir -p ts

# Loop for days 008 to 090
for i in {008..090}
do
  DAY="day-$i"
  echo "→ Setting up $DAY"

  mkdir -p "$DAY"
  
  # For days 015 and onwards, use .ts extension
  if [ $i -ge 015 ]; then
    echo "// Exercises for $DAY" > "$DAY/exercises.ts"
    echo "// Codewars solutions for $DAY" > "codewars/katas-$DAY.ts"
  else
    echo "// Exercises for $DAY" > "$DAY/exercises.js"
    echo "// Codewars solutions for $DAY" > "codewars/katas-$DAY.js"
  fi
  
  echo "# $DAY – Notes" > "$DAY/notes.md"
  echo -e "## Summary for $DAY\n\n- " > "$DAY/summary.md"
done

echo "✅ All folders and files created!" 