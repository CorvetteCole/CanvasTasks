import 'package:CanvasTasks/models/assignment/Assignment.dart';
import 'package:CanvasTasks/models/course/course.dart';
import 'package:CanvasTasks/models/submission/submission_comment.dart';

enum WorkFlowState{
  graded,
  submitted,
  unsubmitted
}

extension ParseToString on WorkFlowState {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class Submission {
  int assignmentId;
  Assignment assignment;
  Course course;
  int attempt;
  String body;
  String grade;
  bool gradeMatchesCurrentSubmission;
  String htmlUrl;
  String previewUrl;
  double score;
  List<SubmissionComment> submissionComments;
  String submissionType;
  String submittedAt;
  String url;
  int userId;
  int graderId;
  String gradedAt;
  User user;
  bool late;
  bool assignmentVisible;
  bool excused;
  bool missing;
  String latePolicyStatus;
  double pointsDeducted;
  int secondsLate;
  String workflowState;
  int extraAttempts;
  String anonymousId;
  String postedAt;

  Submission({this.assignmentId, this.assignment, this.course, this.attempt, this.body, this.grade, this.gradeMatchesCurrentSubmission, this.htmlUrl, this.previewUrl, this.score, this.submissionComments, this.submissionType, this.submittedAt, this.url, this.userId, this.graderId, this.gradedAt, this.user, this.late, this.assignmentVisible, this.excused, this.missing, this.latePolicyStatus, this.pointsDeducted, this.secondsLate, this.workflowState, this.extraAttempts, this.anonymousId, this.postedAt});

  Submission.fromJson(Map<String, dynamic> json) {
    assignmentId = json['assignment_id'];
    assignment = json['assignment'] != null ? new Assignment.fromJson(json['assignment']) : null;
    course = json['course'] != null ? new Course.fromJson(json['course']) : null;
    attempt = json['attempt'];
    body = json['body'];
    grade = json['grade'];
    gradeMatchesCurrentSubmission = json['grade_matches_current_submission'];
    htmlUrl = json['html_url'];
    previewUrl = json['preview_url'];
    score = json['score'];
    if (json['submission_comments'] != null) {
      submissionComments = new List<SubmissionComment>();
      json['submission_comments'].forEach((v) { submissionComments.add(new SubmissionComment.fromJson(v)); });
    }
    submissionType = json['submission_type'];
    submittedAt = json['submitted_at'];
    url = json['url'];
    userId = json['user_id'];
    graderId = json['grader_id'];
    gradedAt = json['graded_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    late = json['late'];
    assignmentVisible = json['assignment_visible'];
    excused = json['excused'];
    missing = json['missing'];
    latePolicyStatus = json['late_policy_status'];
    pointsDeducted = json['points_deducted'];
    secondsLate = json['seconds_late'];
    workflowState = json['workflow_state'];
    extraAttempts = json['extra_attempts'];
    anonymousId = json['anonymous_id'];
    postedAt = json['posted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignment_id'] = this.assignmentId;
    if (this.assignment != null) {
      data['assignment'] = this.assignment.toJson();
    }
    if (this.course != null) {
      data['course'] = this.course.toJson();
    }
    data['attempt'] = this.attempt;
    data['body'] = this.body;
    data['grade'] = this.grade;
    data['grade_matches_current_submission'] = this.gradeMatchesCurrentSubmission;
    data['html_url'] = this.htmlUrl;
    data['preview_url'] = this.previewUrl;
    data['score'] = this.score;
    if (this.submissionComments != null) {
      data['submission_comments'] = this.submissionComments.map((v) => v.toJson()).toList();
    }
    data['submission_type'] = this.submissionType;
    data['submitted_at'] = this.submittedAt;
    data['url'] = this.url;
    data['user_id'] = this.userId;
    data['grader_id'] = this.graderId;
    data['graded_at'] = this.gradedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['late'] = this.late;
    data['assignment_visible'] = this.assignmentVisible;
    data['excused'] = this.excused;
    data['missing'] = this.missing;
    data['late_policy_status'] = this.latePolicyStatus;
    data['points_deducted'] = this.pointsDeducted;
    data['seconds_late'] = this.secondsLate;
    data['workflow_state'] = this.workflowState;
    data['extra_attempts'] = this.extraAttempts;
    data['anonymous_id'] = this.anonymousId;
    data['posted_at'] = this.postedAt;
    return data;
  }
}


class User {
  String name;

  User({this.name});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
