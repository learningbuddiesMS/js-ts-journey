#!/bin/bash

# Source the topics from a separate file
source "$(dirname "$0")/topics.sh"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

create_issue() {
  local day=$1
  local index=$2
  local topic_array=("${@:3}")
  
  # Parse the topic string
  IFS="::" read -r title goals1 goals2 goals3 <<< "${topic_array[$index]}"
  
  # Format the day number with leading zeros
  printf -v day_num "%03d" $day
  
  # Determine file extension based on day number
  ext="js"
  if [ $day -ge 15 ]; then
    ext="ts"
  fi
  
  echo -e "${BLUE}→ Creating issue for day-${day_num}${NC}"
  
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

  # Create the issue using gh cli
  gh issue create --title "Day ${day_num}: ${title}" --body "$body"
  
  # Add a small delay to avoid rate limiting
  sleep 1
}

# Create issues for each phase
echo -e "${BLUE}📝 Creating GitHub issues for all days...${NC}"

for i in {1..14}; do
  create_issue $i $((i-1)) "${TOPICS[@]}"
done

for i in {15..30}; do
  create_issue $i $((i-15)) "${TS_TOPICS[@]}"
done

for i in {31..60}; do
  create_issue $i $((i-31)) "${ADV_TOPICS[@]}"
done

for i in {61..90}; do
  create_issue $i $((i-61)) "${PROJ_TOPICS[@]}"
done

echo -e "${GREEN}✅ All issues created!${NC}" 