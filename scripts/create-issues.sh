#!/bin/bash

# Source the topics from a separate file
source "$(dirname "$0")/topics.sh"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get milestone numbers
get_milestone_number() {
  local title=$1
  gh api \
    -H "Accept: application/vnd.github+json" \
    "/repos/:owner/:repo/milestones" \
    --jq ".[] | select(.title == \"$title\") | .number"
}

create_issue() {
  local day=$1
  local index=$2
  local milestone_title=$3
  local topic_array=("${@:4}")
  
  # Parse the topic string
  IFS="::" read -r title goals1 goals2 goals3 <<< "${topic_array[$index]}"
  
  # Format the day number with leading zeros (2 digits)
  printf -v day_num "%02d" $day
  
  # Determine file extension based on day number
  ext="js"
  if [ $day -ge 15 ]; then
    ext="ts"
  fi
  
  echo -e "${BLUE}→ Creating issue for day-${day_num}${NC}"
  
  # Get milestone number
  milestone_number=$(get_milestone_number "$milestone_title")
  
  # Create the issue body
  body="### 📘 Topic  
Day ${day_num}: ${title}

### 🧠 Learning Goals
- ${goals1}
- ${goals2}
- ${goals3}

### 🧪 Tasks
- [ ] Complete daily learning materials
- [ ] Implement examples in \`day-${day_num}/exercises.${ext}\`
- [ ] Write notes in \`day-${day_num}/notes.md\`
- [ ] Summarize learnings in \`day-${day_num}/summary.md\`
- [ ] Solve 2 Codewars katas and add to \`codewars/katas-day-${day_num}.${ext}\`

### 🔁 Optional
- [ ] Push your code to GitHub
- [ ] Close this issue"

  # Create the issue using gh cli with milestone
  if [ -n "$milestone_number" ]; then
    gh issue create --title "Day ${day_num}: ${title}" --body "$body" --milestone "$milestone_number"
  else
    gh issue create --title "Day ${day_num}: ${title}" --body "$body"
  fi
  
  # Add a small delay to avoid rate limiting
  sleep 1
}

# Create issues for each phase
echo -e "${BLUE}📝 Creating GitHub issues for all days...${NC}"

# First create milestones
echo -e "${BLUE}📅 Creating milestones first...${NC}"
"$(dirname "$0")/create-milestones.sh"

# Create issues in reverse order
# Days 90-61: Real-world Projects
for i in $(seq 90 -1 61); do
  create_issue $i $((i-61)) "Real-world Projects" "${PROJ_TOPICS[@]}"
done

# Days 60-31: Advanced Web Development
for i in $(seq 60 -1 31); do
  create_issue $i $((i-31)) "Advanced Web Development" "${ADV_TOPICS[@]}"
done

# Days 30-15: TypeScript & Advanced Concepts
for i in $(seq 30 -1 15); do
  create_issue $i $((i-15)) "TypeScript & Advanced Concepts" "${TS_TOPICS[@]}"
done

# Days 14-1: JavaScript Fundamentals
for i in $(seq 14 -1 1); do
  create_issue $i $((i-1)) "JavaScript Fundamentals" "${TOPICS[@]}"
done

echo -e "${GREEN}✅ All issues created!${NC}" 