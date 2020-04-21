import 'dart:convert';
import 'dart:io';

//import 'dart:js';
//import 'package:js/js.dart';

//import 'package:CanvasTasks/models/Assignment.dart';
import 'package:CanvasTasks/models/assignment/Assignment.dart';
import 'package:CanvasTasks/models/course/course.dart';
import 'package:CanvasTasks/tasks.dart';
import 'package:CanvasTasks/url_fetch.dart';

import 'package:google_apps/drive.dart';
import 'package:CanvasTasks/secrets.dart';
import 'package:tuple/tuple.dart';

//import 'package:http/http.dart' as http;

void main() async {
  print('hello!!!');

  var taskTitles = 'Task titles: ';
  String testID;
  for (var tasklist in Tasklists.list().items) {
    if (tasklist.title == 'test') {
      testID = tasklist.id;
    }
    //taskTitles += '${tasklist.title}, ';
  }

  for (var course in await fetchCourses()) {
    if (course.isFavorite && !course.isConcluded && course.term.id == 10556) {
      print(course.courseCodeTruncated);
      addToTasks(await fetchAssignments(course.id), course.courseCodeTruncated,
          testID);
    }
  }

//  for (var task in Tasks.list(testID).items) {
//    Tasks.remove(testID, task.id);
//  }
  //Tasks.clear(testID);

  //
  //    for (var response in responseJsonList){
  //      print(response);
  //      //print(response.runtimeType);
  //      print(Assignment.fromJson(response).name);

  //fetchAssignmentList();

  //var responseJsonList = jsonDecode(response.getContentText()) as List<dynamic>;
  //var assignments = <Assignment>[];
  //for (Map<String, dynamic> response in responseJsonList){
  //  print(response);
  //  print('-------------');
  //print(response.keys);
  //print(Assignment.fromJson(response).name);
  //assignments.add(Assignment.fromJson(jsToMap(response) as Map<String, dynamic>));
  //}

  //var assignments = await fetchAssignmentList();
}

Future<List<Course>> fetchCourses() async {
  var rawResponse = UrlFetchApp.fetch(
    'https://uk.instructure.com/api/v1/courses/?enrollment_state=active&state=available&include[]=favorites&include[]=concluded&include[]=term&exclude_blueprint_courses=true&per_page=100&access_token=$canvas_key',
  );
  var courses = <Course>[];
  var responseJsonList =
      jsonDecode(await rawResponse.getContentText()) as List<dynamic>;
  for (var response in responseJsonList) {
    courses.add(Course.fromJson(response));
    //print(courses.last.courseCode);
  }
  return courses;
}

Future<List<Assignment>> fetchAssignments(int courseID) async {
  var assignments = <Assignment>[];
  var rawResponse = UrlFetchApp.fetch(
    'https://uk.instructure.com/api/v1/courses/$courseID/assignments?include=all_dates&bucket=upcoming&per_page=100&access_token=$canvas_key',
  );

  var responseJsonList =
      jsonDecode(await rawResponse.getContentText()) as List<dynamic>;

  rawResponse = UrlFetchApp.fetch(
    'https://uk.instructure.com/api/v1/courses/$courseID/assignments?include=all_dates&bucket=undated&per_page=100&access_token=$canvas_key',
  );
  responseJsonList
      .addAll(jsonDecode(await rawResponse.getContentText()) as List<dynamic>);

  rawResponse = UrlFetchApp.fetch(
    'https://uk.instructure.com/api/v1/courses/$courseID/assignments?include=all_dates&bucket=future&per_page=100&access_token=$canvas_key',
  );

  responseJsonList
      .addAll(jsonDecode(await rawResponse.getContentText()) as List<dynamic>);
  for (var response in responseJsonList) {
    var assignment = Assignment.fromJson(response);
    print(assignment.name);
    print('DateTime now: ${DateTime.now()}');
    if (assignment.dueAt?.isNotEmpty ?? false) {
      print('dueAt: ${DateTime.parse(assignment.dueAt).toLocal()}');
      print(
          'should be added? ${DateTime.parse(assignment.dueAt).toLocal().isAfter(DateTime.now())}');
      if (DateTime.parse(assignment.dueAt).toLocal().isAfter(DateTime.now())) {
        assignments.add(Assignment.fromJson(response));
      }
    } else if (assignment.lockAt?.isNotEmpty ?? false) {
      print('lockAt: ${DateTime.parse(assignment.lockAt).toLocal()}');
      print(
          'should be added? ${DateTime.parse(assignment.lockAt).toLocal().isAfter(DateTime.now())}');
      if (DateTime.parse(assignment.lockAt).toLocal().isAfter(DateTime.now())) {
        assignments.add(Assignment.fromJson(response));
      }
    }
    //print(assignments.last.name);
  }
  return assignments;
}

void addToTasks(
    List<Assignment> assignments, String courseName, String testID) {
  var tasks = <String, Tuple2<Task, Task>>{};
  // create map of all tasks
  for (var assignment in assignments) {
    var newTask = Task()
      ..title = '$courseName: ${assignment.name}'
      ..notes = assignment.description
      ..due = assignment.dueAt;
    //print('should print something here....');
    if (assignment.dueAt?.isEmpty ?? true) {
      newTask.due = assignment.lockAt;
    }

    if (newTask.due != null) {
      newTask.due = DateTime.parse(newTask.due).subtract(Duration(hours: 8)).toUtc().toIso8601String();
    }
    print('${newTask.title} due: ${newTask.due} locks: ${assignment.lockAt}');

    tasks[newTask.title] = Tuple2(newTask, null);
  }

  // check if tasks have a pair, if so add them
  if (Tasks.list(testID)?.items?.isNotEmpty ?? false) {
    for (var task in Tasks.list(testID).items) {
      if (tasks.containsKey(task.title)) {
        tasks[task.title] = tasks[task.title].withItem2(task);
      }
    }
  }

  for (var taskTuple in tasks.values) {
    if (taskTuple.item2 != null &&
        (taskTuple.item1.notes != taskTuple.item2.notes ||
            taskTuple.item1.due != taskTuple.item2.due)) {
      taskTuple.item2.notes = taskTuple.item1.notes;
      taskTuple.item2.due = taskTuple.item1.due;
      Tasks.update(taskTuple.item2, testID, taskTuple.item2.id);
    } else {
      Tasks.insert(taskTuple.item1, testID);
    }
  }
}
