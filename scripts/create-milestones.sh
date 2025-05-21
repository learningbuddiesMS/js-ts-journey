#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Define milestone titles and descriptions
MILESTONE_TITLES=(
  "JavaScript Fundamentals"
  "TypeScript & Advanced Concepts"
  "Advanced Web Development"
  "Real-world Projects"
)

MILESTONE_DESCRIPTIONS=(
  "Days 01-14: Master core JavaScript concepts, DOM manipulation, and async programming"
  "Days 15-30: Learn TypeScript fundamentals and advanced programming concepts"
  "Days 31-60: Deep dive into advanced web development topics and best practices"
  "Days 61-90: Build complete projects and prepare for professional development"
)

# Create milestones
echo -e "${BLUE}📅 Creating milestones...${NC}"

for i in "${!MILESTONE_TITLES[@]}"; do
  title="${MILESTONE_TITLES[$i]}"
  description="${MILESTONE_DESCRIPTIONS[$i]}"
  echo -e "${BLUE}→ Creating milestone: ${title}${NC}"
  
  # Calculate due date based on milestone
  case $i in
    0) due_date=$(date -v+14d +%Y-%m-%d) ;; # JavaScript Fundamentals
    1) due_date=$(date -v+30d +%Y-%m-%d) ;; # TypeScript & Advanced Concepts
    2) due_date=$(date -v+60d +%Y-%m-%d) ;; # Advanced Web Development
    3) due_date=$(date -v+90d +%Y-%m-%d) ;; # Real-world Projects
  esac
  
  # Create milestone using GitHub CLI
  gh milestone create "$title" \
    --description "$description" \
    --due-date "${due_date}T23:59:59Z"
done

echo -e "${GREEN}✅ All milestones created!${NC}" 