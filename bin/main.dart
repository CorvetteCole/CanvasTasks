import 'dart:convert';
import 'dart:io';

//import 'dart:js';
//import 'package:js/js.dart';

//import 'package:CanvasTasks/models/Assignment.dart';
import 'package:CanvasTasks/canvas.dart';
import 'package:CanvasTasks/models/assignment/Assignment.dart';
import 'package:CanvasTasks/models/course/course.dart';
import 'package:CanvasTasks/models/submission/submission.dart';
import 'package:CanvasTasks/google_apps_scripts/properties.dart';
import 'package:CanvasTasks/tasks.dart';
import 'package:CanvasTasks/google_apps_scripts/url_fetch.dart';
import 'package:CanvasTasks/google_apps_scripts/cache.dart';

import 'package:google_apps/drive.dart';
import 'package:CanvasTasks/secrets.dart';
import 'package:tuple/tuple.dart';

//import 'package:http/http.dart' as http;

const int termId = 10597;

const String coursesUpdatedKey = 'courses_updated';
const int coursesUpdateInterval = 7;
const int assignmentsFullUpdateInterval = 3;

enum Goal { updateRecentAssignments, updateAllAssignmentsForCourse }

var cache = CacheService.getUserCache();
var properties = PropertiesService.getUserProperties();

void main() async {
  //print('hello!!!');
  var startTime = DateTime.now();

//  var canvasTaskList = getCanvasTaskListId();
//  for (var task in Tasks.list(canvasTaskList, TaskOptions(showHidden: true)).items){
//    Tasks.remove(canvasTaskList, task.id);
//
//  }
// properties.deleteAllProperties();

  var courseUpdateNeeded = shouldUpdateCourses();

  var canvas = courseUpdateNeeded
      ? Canvas(termId, canvas_key, cache, properties, true)
      : Canvas(termId, canvas_key, cache, properties, false);

  if (await canvas.courses > 0) {
    if (courseUpdateNeeded) {
      print('setting course update timestamp...');
      properties.setProperty(
          coursesUpdatedKey, DateTime.now().toUtc().toIso8601String());
    }
    switch (getGoal()) {
      case Goal.updateRecentAssignments:
        print('update recent assignments');
        addToTasks(await canvas.getAssignments(), getCanvasTaskListId());
        break;
      case Goal.updateAllAssignmentsForCourse:
        print('updating all assignments for course');
        addToTasks(await canvas.getAssignments(getFromCourse: true),
            getCanvasTaskListId());
        break;
    }
  }

  print('time to run: ${startTime.difference(DateTime.now()).abs().inSeconds}');
}

bool shouldUpdateCourses() {
  var coursesUpdated = properties.getProperty(coursesUpdatedKey);
  return coursesUpdated == null ||
      DateTime.parse(coursesUpdated).difference(DateTime.now()) >
         Duration(days: coursesUpdateInterval);
}

String getCanvasTaskListId() {
  String canvasTaskListId;
  for (var tasklist in Tasklists.list().items) {
    if (tasklist.title == 'Canvas') {
      canvasTaskListId = tasklist.id;
      break;
    }
  }
  canvasTaskListId ??= Tasklists.insert(Tasklist()..title = 'Canvas').id;
  print('canvas task list id: $canvasTaskListId');
  return canvasTaskListId;
}

Goal getGoal() {
  var assignmentsFullyUpdated = properties.getProperty(assignmentsUpdatedKey);
  if (assignmentsFullyUpdated == null ||
      DateTime.parse(assignmentsFullyUpdated).difference(DateTime.now()).abs() >
          Duration(days: assignmentsFullUpdateInterval)) {
    return Goal.updateAllAssignmentsForCourse;
  } else {
    return Goal.updateRecentAssignments;
  }
}

// TODO move this method to its own class, split up the internals
void addToTasks(Map<String, Set<Assignment>> assignments, String taskListId) {
  var tasks = <String, Tuple2<Task, Task>>{};
  // create map of all tasks
  for (var courseName in assignments.keys) {
    for (var assignment in assignments[courseName]) {
      var newTask = Task()
        ..title = '$courseName: ${assignment.name}'
        ..notes = assignment.description
        ..due = assignment.dueAt;

      // get task status
      if (assignment.isComplete) {
        print('${assignment.name} is completed');
        newTask.status = TaskStatus.completed.toShortString();
      } else {
        print('${assignment.name} is not completed');
      }

      if (assignment.dueAt?.isEmpty ?? true) {
        newTask.due = assignment.lockAt;
      }

      if (newTask.due != null) {
        newTask.due = DateTime.parse(newTask.due)
            .subtract(//TODO: fix this
                Duration(
                    hours: 8)) //temp subtract 8 to get around Tasks date bug
            .toUtc()
            .toIso8601String();
      }
//    print (
//        '${newTask.title} due: ${newTask.due} locks: ${assignment.lockAt} submitted: ${assignment.hasSubmittedSubmissions}');

      tasks[newTask.title] = Tuple2(newTask, null);
    }
  }

  List<Task> getTasks(String taskLisId, {String nextPageToken}) {
    var taskList = nextPageToken != null
        ? Tasks.list(
            taskListId,
            TaskOptions(
                showHidden: true, maxResults: 100, pageToken: nextPageToken))
        : Tasks.list(
            taskListId, TaskOptions(showHidden: true, maxResults: 100));
    if (taskList.items.length == 100 && taskList.nextPageToken != null) {
      taskList.items
          .addAll(getTasks(taskListId, nextPageToken: taskList.nextPageToken));
    }
    return taskList.items;
  }

  // check if tasks have a pair, if so add them
  //DriveApp.createFile('CanvasTasksTaskList.txt', Tasks.list(taskListId).items);

  var taskList = getTasks(taskListId);

  if (taskList?.isNotEmpty ?? false) {
    for (var task in taskList) {
      if (tasks.containsKey(task.title)) {
        print('task ${task.title} already exists... adding to tuple');
        tasks[task.title] = tasks[task.title].withItem2(task);
      }
    }
  }

  //TODO: sort so closest date is at top
  for (var taskTuple in tasks.values) {
    // check if tasks need to be updated, if so, update them
    if (taskTuple.item2 != null &&
        (taskTuple.item1.notes != taskTuple.item2.notes ||
            DateTime.parse(taskTuple.item1.due).day !=
                DateTime.parse(taskTuple.item2.due).day ||
            taskTuple.item1.status != taskTuple.item2.status)) {
      taskTuple.item2.notes = taskTuple.item1.notes;
      taskTuple.item2.due = taskTuple.item1.due;
      // only update task status if it has not been completed by the user so the user can manually mark things as complete
      if (taskTuple.item2.status != TaskStatus.completed.toShortString()) {
        taskTuple.item2.status = taskTuple.item1.status;
      }
      Tasks.update(taskTuple.item2, taskListId, taskTuple.item2.id);
    } else if (taskTuple.item2 == null) {
      print('task ${taskTuple.item1.title} does not exist, inserting...');
      Tasks.insert(taskTuple.item1, taskListId);
    }
  }
}
