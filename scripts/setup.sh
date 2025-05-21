#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Utility function to create directory structure
create_day_structure() {
  local day=$1
  local ext=$2
  
  # Format day number with leading zeros
  printf -v day_num "%03d" $day
  
  echo -e "${BLUE}→ Setting up day-${day_num}${NC}"
  
  # Create directories
  mkdir -p "day-${day_num}"
  
  # Create files
  echo "// Exercises for day-${day_num}" > "day-${day_num}/exercises.${ext}"
  echo "# Day ${day_num} – Notes" > "day-${day_num}/notes.md"
  echo -e "## Summary for day-${day_num}\n\n- " > "day-${day_num}/summary.md"
  echo "// Codewars solutions for day-${day_num}" > "codewars/katas-day-${day_num}.${ext}"
}

# Create shared directories
echo -e "${BLUE}📁 Creating shared directories...${NC}"
mkdir -p codewars
mkdir -p projects
mkdir -p ts

# Create days 001-090
echo -e "${BLUE}📁 Creating folders and files for days 001-090...${NC}"

# Days 001-014: JavaScript
for i in $(seq 1 14); do
  create_day_structure $i "js"
done

# Days 015-090: TypeScript
for i in $(seq 15 90); do
  create_day_structure $i "ts"
done

echo -e "${GREEN}✅ All folders and files created!${NC}" 