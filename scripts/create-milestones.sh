#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Define milestones
declare -A MILESTONES=(
  ["JavaScript Fundamentals"]="Days 01-14: Master core JavaScript concepts, DOM manipulation, and async programming"
  ["TypeScript & Advanced Concepts"]="Days 15-30: Learn TypeScript fundamentals and advanced programming concepts"
  ["Advanced Web Development"]="Days 31-60: Deep dive into advanced web development topics and best practices"
  ["Real-world Projects"]="Days 61-90: Build complete projects and prepare for professional development"
)

# Create milestones
echo -e "${BLUE}📅 Creating milestones...${NC}"

for title in "${!MILESTONES[@]}"; do
  description="${MILESTONES[$title]}"
  echo -e "${BLUE}→ Creating milestone: ${title}${NC}"
  
  # Calculate due date (30 days from now for each phase)
  if [[ $title == *"JavaScript Fundamentals"* ]]; then
    due_date=$(date -v+14d +%Y-%m-%d)
  elif [[ $title == *"TypeScript & Advanced Concepts"* ]]; then
    due_date=$(date -v+30d +%Y-%m-%d)
  elif [[ $title == *"Advanced Web Development"* ]]; then
    due_date=$(date -v+60d +%Y-%m-%d)
  else
    due_date=$(date -v+90d +%Y-%m-%d)
  fi
  
  # Create milestone using GitHub CLI
  gh api \
    --method POST \
    -H "Accept: application/vnd.github+json" \
    /repos/:owner/:repo/milestones \
    -f title="$title" \
    -f description="$description" \
    -f due_on="${due_date}T23:59:59Z"
done

echo -e "${GREEN}✅ All milestones created!${NC}" 