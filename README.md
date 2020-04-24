# Canvas - Google Tasks Integration
Automatically put assignments from Canvas in to Google Tasks. Mark tasks as completed automatically after assignments 
are submitted.

# Commands
``` sh
dart2js --csp -o CanvasTasks.js bin/main.dart
pub global run apps_script_tools:main CanvasTasks.js CanvasTasks
# or
pub global run apps_script_tools:gsify CanvasTasks.js -o CanvasTasks
```
