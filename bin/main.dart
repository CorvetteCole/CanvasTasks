import 'package:google_apps/drive.dart';
import 'package:CanvasTasks/tasks.dart';

void main() {
  var taskTitles = 'Task titles: ';
  String testID;

  for (var tasklist in Tasklists.list().items) {
    if (tasklist.title == 'test'){
      testID = tasklist.id;
    }
    //taskTitles += '${tasklist.title}, ';
  }
  for (var i = 0; i < 20; i++){
    var newTask = Task()
    ..title = 'test $i'
    ..notes = 'this is a test of inserting tasks';

    Tasks.insert(newTask, testID);
  }


  //DriveApp.createFile('TaskTitles.txt', taskTitles);
}
