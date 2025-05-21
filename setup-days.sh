#!/bin/bash

echo "📁 Creating folders and files for days 001-007..."

# Create shared directories
mkdir -p codewars
mkdir -p projects
mkdir -p ts

# Loop for days 001 to 007
for i in {001..007}
do
  DAY="day-$i"
  echo "→ Setting up $DAY"

  mkdir -p "$DAY"
  echo "// Exercises for $DAY" > "$DAY/exercises.js"
  echo "# $DAY – Notes" > "$DAY/notes.md"
  echo -e "## Summary for $DAY\n\n- " > "$DAY/summary.md"
  echo "// Codewars solutions for $DAY" > "codewars/katas-$DAY.js"
done

echo "✅ All folders and files created!"