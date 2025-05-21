#!/bin/bash

# JavaScript Fundamentals (Days 8-14)
TOPICS=(
  "JavaScript Basics – Variables & Data Types::Master var, let, const, and primitive types::Learn about variables, strings, numbers, booleans::Practice type conversion and basic operations"
  "Control Flow & Loops::Master if/else, switch, and loops::Understand logical operators::Practice different loop types"
  "Functions & Scope::Learn function declarations and expressions::Understand scope and closures::Practice arrow functions"
  "Arrays & Array Methods::Master array manipulation::Learn map, filter, reduce::Practice array methods"
  "Objects & Object Methods::Learn object creation and methods::Understand prototypes::Practice object manipulation"
  "Error Handling & Debugging::Master try/catch blocks::Learn debugging techniques::Practice error handling"
  "Asynchronous Basics::Understand callbacks::Learn Promise basics::Practice basic async code"
)

# TypeScript & Advanced Concepts (Days 15-30)
TS_TOPICS=(
  "TypeScript Basics::Learn TypeScript setup::Understand basic types::Practice type annotations"
  "Interfaces & Types::Master interface creation::Learn type aliases::Practice type definitions"
  "Classes in TypeScript::Understand OOP in TypeScript::Learn class implementation::Practice class creation"
  "Generics::Master generic types::Learn generic constraints::Practice generic implementations"
  "Advanced Types::Understand union and intersection::Learn type guards::Practice type manipulation"
  "Decorators::Learn decorator patterns::Understand metadata::Practice decorator creation"
  "Modules & Namespaces::Master module systems::Learn namespace usage::Practice organization"
  "Advanced Functions::Understand function overloading::Learn this binding::Practice advanced patterns"
  "Async/Await::Master async/await::Learn error handling::Practice async patterns"
  "TypeScript Configuration::Understand tsconfig::Learn compiler options::Practice configuration"
  "DOM Manipulation::Master DOM with TypeScript::Learn event handling::Practice DOM manipulation"
  "Project Structure::Learn project organization::Understand best practices::Practice architecture"
  "Testing Basics::Learn Jest setup::Understand unit testing::Practice test writing"
  "API Integration::Master HTTP requests::Learn RESTful principles::Practice API calls"
  "State Management::Understand state patterns::Learn local storage::Practice state handling"
  "Performance::Master optimization::Learn performance metrics::Practice improvements"
)

# Advanced Concepts (Days 31-60)
ADV_TOPICS=(
  "Advanced DOM::Deep dive into DOM::Learn virtual DOM::Practice advanced manipulation"
  "Browser Storage::Master localStorage/sessionStorage::Learn IndexedDB::Practice data persistence"
  "Web Components::Understand custom elements::Learn shadow DOM::Practice component creation"
  "Advanced Async::Master async patterns::Learn generators::Practice concurrent operations"
  "Design Patterns::Understand common patterns::Learn implementation::Practice pattern usage"
  "Functional Programming::Master pure functions::Learn immutability::Practice FP concepts"
  "Memory Management::Understand garbage collection::Learn memory leaks::Practice optimization"
  "Security Best Practices::Master OWASP guidelines::Learn common vulnerabilities::Practice secure coding"
  "Build Tools::Understand bundlers::Learn optimization::Practice configuration"
  "Testing Strategies::Master testing patterns::Learn E2E testing::Practice test automation"
  "CI/CD Basics::Understand pipelines::Learn automation::Practice deployment"
  "Code Quality::Master linting::Learn code reviews::Practice refactoring"
  "Microservices::Understand architecture::Learn communication::Practice implementation"
  "GraphQL Basics::Master queries::Learn mutations::Practice integration"
  "WebSockets::Understand real-time::Learn protocols::Practice implementation"
  "Progressive Web Apps::Master service workers::Learn caching::Practice PWA features"
  "Web APIs::Understand modern APIs::Learn implementation::Practice integration"
  "Browser Extensions::Master extension APIs::Learn architecture::Practice development"
  "Desktop Apps::Understand Electron::Learn packaging::Practice development"
  "Mobile Development::Master React Native basics::Learn mobile patterns::Practice app creation"
  "Cloud Integration::Understand services::Learn deployment::Practice cloud usage"
  "Monitoring::Master logging::Learn analytics::Practice monitoring"
  "Performance Testing::Understand metrics::Learn tools::Practice optimization"
  "Documentation::Master JSDoc::Learn documentation::Practice writing"
  "Community Contribution::Understand open source::Learn collaboration::Practice contributing"
  "Architecture Patterns::Master patterns::Learn implementation::Practice design"
  "Scalability::Understand scaling::Learn optimization::Practice implementation"
  "Security Testing::Master security tests::Learn vulnerabilities::Practice prevention"
  "Code Migration::Understand strategies::Learn tools::Practice migration"
  "Final Project::Apply all concepts::Create full application::Practice integration"
)

# Days 61-90: Real-world Projects and Specialization
PROJ_TOPICS=(
  "Project Planning::Define requirements::Plan architecture::Create roadmap"
  "Frontend Framework::Choose framework::Learn basics::Build components"
  "State Management::Implement state::Handle data flow::Manage side effects"
  "API Design::Plan endpoints::Implement REST::Handle errors"
  "Database Integration::Choose database::Design schema::Implement CRUD"
  "Authentication::Implement auth::Handle sessions::Secure routes"
  "File Handling::Upload files::Process data::Handle storage"
  "Search Implementation::Design search::Implement filters::Optimize performance"
  "Real-time Features::Add WebSocket::Handle events::Manage state"
  "Analytics::Add tracking::Process data::Create reports"
  "Optimization::Improve loading::Optimize code::Enhance UX"
  "Testing Suite::Write tests::Automate testing::Ensure coverage"
  "Documentation::Write docs::Generate API docs::Create guides"
  "Deployment::Setup pipeline::Configure servers::Deploy app"
  "Monitoring::Add logging::Track errors::Monitor performance"
  "User Feedback::Gather feedback::Implement changes::Improve features"
  "Code Review::Review code::Implement feedback::Improve quality"
  "Security Audit::Check security::Fix vulnerabilities::Implement best practices"
  "Performance Audit::Check performance::Optimize code::Improve metrics"
  "Final Deployment::Deploy project::Monitor performance::Handle feedback"
  "Project Presentation::Present project::Document learning::Share knowledge"
  "Code Cleanup::Refactor code::Improve structure::Enhance readability"
  "Future Planning::Plan updates::Consider scaling::Document roadmap"
  "Knowledge Sharing::Share learning::Help others::Build community"
  "Career Planning::Update portfolio::Prepare resume::Plan next steps"
  "Interview Prep::Practice problems::Review concepts::Prepare examples"
  "System Design::Practice design::Review patterns::Prepare solutions"
  "Advanced Concepts::Deep dive topics::Master concepts::Prepare examples"
  "Final Review::Review journey::Document growth::Plan future"
  "Celebration::Complete journey::Share success::Plan continuation"
)

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
for i in {8..14}; do
  create_issue $i $((i-8)) "${TOPICS[@]}"
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

echo "✅ All issues created!" 