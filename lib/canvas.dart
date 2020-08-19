import 'dart:convert';

import 'package:CanvasTasks/google_apps_scripts/url_fetch.dart';
import 'package:CanvasTasks/parse_link_header.dart';
import 'package:CanvasTasks/utilities.dart';
import 'package:google_apps/drive.dart';
import 'package:http/http.dart';
import 'package:tuple/tuple.dart';

import 'models/assignment/Assignment.dart';
import 'models/course/course.dart';
import 'google_apps_scripts/properties.dart';
import 'models/submission/submission.dart';

import 'google_apps_scripts/cache.dart';

const String assignmentsUpdatedKey = 'assignments_updated';
const String _courseIdsCacheKey = 'course_ids';
const String _courseNamesCacheKey = 'course_names';
const String _courseIndexPropertyKey = 'course_index';
const Duration _cacheExpiration = Duration(hours: 1);

class Canvas {
  final int _termId;
  final String _canvasKey;
  final bool _forceCourseUpdate;
  final Cache _cache;
  final Properties _properties;
  var _courses = <int, String>{};

  Canvas(this._termId, this._canvasKey, this._cache, this._properties,
      [this._forceCourseUpdate = false]);

  // id, name
  Future<int> get courses async {
    var cachedIds = _cache.get(_courseIdsCacheKey);
    var cachedNames = _cache.get(_courseNamesCacheKey);
    if (cachedIds == null || cachedNames == null || _forceCourseUpdate) {
      for (var course in await _fetchCourses()) {
        if (course.term.id == _termId) {
          _courses[course.id] = course.courseCodeTruncated;
        }
      }

      _cache.put(_courseIdsCacheKey, _courses.keys.join(','),
          _cacheExpiration.inSeconds);
      _cache.put(_courseNamesCacheKey, _courses.values.join(','),
          _cacheExpiration.inSeconds);
    } else {
      var idSet = cachedIds.split(',').map((id) => int.parse(id)).toSet();
      var nameSet = cachedNames.split(',').toSet();

      _courses.addAll(Map.fromIterables(idSet, nameSet));
    }

    // return number of courses retrieved
    return _courses.length;
  }

  Future<Map<String, Set<Assignment>>> getAssignments(
      {bool getFromCourse = false}) async {
    var assignments = <String, Set<Assignment>>{};
    if (getFromCourse) {
      var savedCourseIndexString =
          _properties.getProperty(_courseIndexPropertyKey);
      var savedCourseIndex = 0;
      if (savedCourseIndexString != null) {
        savedCourseIndex = int.parse(savedCourseIndexString);
      }

      var courseId = _courses.keys.elementAt(savedCourseIndex);
      print('updating all assignments from ${_courses[courseId]}');
      assignments[_courses[courseId]] =
          await _fetchAllAssignmentsFromCourse(courseId);
      if (savedCourseIndex < _courses.length - 1) {
        _properties.setProperty(
            _courseIndexPropertyKey, (savedCourseIndex + 1).toString());
      } else {
        _properties.setProperty(_courseIndexPropertyKey, (0).toString());
        _properties.setProperty(
            assignmentsUpdatedKey, DateTime.now().toUtc().toIso8601String());
      }
    } else {
      assignments = await _fetchAssignments();
    }
    return assignments;
  }

  Future<List<Course>> _fetchCourses() async {
    var rawResponse = UrlFetchApp.fetch(
      'https://uk.instructure.com/api/v1/courses/?enrollment_state=active&state=available&include[]=favorites&include[]=concluded&include[]=term&exclude_blueprint_courses=true&per_page=100&access_token=$_canvasKey',
    );

//    DriveApp.createFile(
//        'CanvasTasksResponseCourses.txt', rawResponse.getContentText());
    //print(rawResponse.getAllHeaders());
    var courses = <Course>[];
    var responseJsonList =
        jsonDecode(await rawResponse.getContentText()) as List<dynamic>;
    for (var response in responseJsonList) {
      courses.add(Course.fromJson(response));
      //print(courses.last.courseCode);
    }
    return courses;
  }

  Future<Set<Assignment>> _fetchAllAssignmentsFromCourse(int courseId,
      [String paginationURL]) async {
    var assignments = <Assignment>{};
    var url = paginationURL ??
        'https://uk.instructure.com/api/v1/courses/$courseId/assignments?include[]=all_dates&include[]=submission&order_by=due_at&per_page=100';
    var rawResponse = UrlFetchApp.fetch('$url&access_token=$_canvasKey');
    if (rawResponse.getResponseCode() == 200) {
      // request succeeded
      var responseJsonList =
          jsonDecode(await rawResponse.getContentText()) as List<dynamic>;
      for (var response in responseJsonList) {
        var assignment = Assignment.fromJson(response);

        // only add assignments with dates attached
        if ((assignment.dueAt?.isNotEmpty ?? false) ||
            (assignment.lockAt?.isNotEmpty ?? false)) {
          assignments.add(assignment);
        }
      }

      var headers = jsToMap(rawResponse.getAllHeaders());
      if (headers.containsKey('Link')) {
        var pagination = Pagination.parse(headers['Link']);
        // recursive call to get all pages
        if (pagination.hasNext) {
          //print('Going to next page...');
          print('whew lad, lots of pages. On to page ${pagination.totalPage}!');
          assignments.union(
              await _fetchAllAssignmentsFromCourse(courseId, pagination.next));
        }
      }
    }
    return assignments;
  }

  Future<Map<String, Set<Assignment>>> _fetchAssignments() async {
    var assignments = <String, Set<Assignment>>{};
    var urls = <String>[];
    for (var courseId in _courses.keys) {
      print('adding URL to list');
      urls.add(
          'https://uk.instructure.com/api/v1/courses/$courseId/assignments?include[]=all_dates&include[]=submission&per_page=25&access_token=$_canvasKey');
    }
    var rawResponses = UrlFetchApp.fetchAll(urls);
    var index = 0;
    for (var rawResponse in rawResponses) {
      print('parsing rawResponse $index');
      var responseJsonList =
          jsonDecode(await rawResponse.getContentText()) as List<dynamic>;
      var assignmentsSet = <Assignment>{};
      for (var response in responseJsonList) {
        var assignment = Assignment.fromJson(response);
        // only add assignments with dates attached
        if ((assignment.dueAt?.isNotEmpty ?? false) ||
            (assignment.lockAt?.isNotEmpty ?? false)) {
          assignmentsSet.add(assignment);
        }
      }
      assignments[_courses.values.elementAt(index)] = assignmentsSet;
      index++;
    }
    return assignments;
  }
}
