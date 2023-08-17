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

## Newer Commands with Extra Jank!
(I am too lazy to bring this and all of its dependencies up to date for a single remaining semester)
```sh
/opt/dart2-sdk/bin/dart compile js --csp -o CanvasTasks.js bin/main.dart
/opt/dart2-sdk/bin/dart pub global activate apps_script_tools
/opt/dart2-sdk/bin/dart pub global run apps_script_tools:gsify CanvasTasks.js -o CanvasTasks
```