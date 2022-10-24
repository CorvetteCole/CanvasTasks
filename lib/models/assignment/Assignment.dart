import 'dart:convert';

import 'package:CanvasTasks/models/assignment/AssignmentDate.dart';
import 'package:CanvasTasks/models/assignment/AssignmentOverride.dart';
import 'package:CanvasTasks/models/assignment/ExternalToolTagAttributes.dart';
import 'package:CanvasTasks/models/assignment/LockInfo.dart';
import 'package:CanvasTasks/models/assignment/RubricCriteria.dart';
import 'package:CanvasTasks/models/assignment/RubricRating.dart';
import 'package:CanvasTasks/models/assignment/TurnitinSettings.dart';
import 'package:CanvasTasks/models/submission/submission.dart';


enum SubmissionType{
  discussion_topic,
  online_quiz,
  on_paper,
  none,
  external_tool,
  online_text_entry,
  online_url,
  online_upload,
  media_recording
}

extension ParseToString on SubmissionType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class Assignment {
  int id;
  String name;
  String description;
  String createdAt;
  String updatedAt;
  String dueAt;
  String lockAt;
  String unlockAt;
  bool hasOverrides;
  List<AssignmentDate> allDates;
  int courseId;
  String htmlUrl;
  String submissionsDownloadUrl;
  int assignmentGroupId;
  bool dueDateRequired;
  List<String> allowedExtensions;
  int maxNameLength;
  bool turnitinEnabled;
  bool vericiteEnabled;
  TurnitinSettings turnitinSettings;
  bool gradeGroupStudentsIndividually;
  ExternalToolTagAttributes externalToolTagAttributes;
  bool peerReviews;
  bool automaticPeerReviews;
  int peerReviewCount;
  String peerReviewsAssignAt;
  bool intraGroupPeerReviews;
  int groupCategoryId;
  int needsGradingCount;
  List<NeedsGradingCountBySection> needsGradingCountBySection;
  int position;
  bool postToSis;
  String integrationId;
  IntegrationData integrationData;
  bool muted;
  num pointsPossible;
  List<String> submissionTypes;
  bool hasSubmittedSubmissions;
  String gradingType;
  int gradingStandardId;
  bool published;
  bool unpublishable;
  bool onlyVisibleToOverrides;
  bool lockedForUser;
  LockInfo lockInfo;
  String lockExplanation;
  int quizId;
  bool anonymousSubmissions;

  //Null discussionTopic;
  bool freezeOnCopy;
  bool frozen;
  List<String> frozenAttributes;

  Submission submission;
  bool useRubricForGrading;
  RubricSettings rubricSettings;
  List<RubricCriteria> rubric;
  List<int> assignmentVisibility;
  List<AssignmentOverride> overrides;
  bool omitFromFinalGrade;
  bool moderatedGrading;
  int graderCount;
  int finalGraderId;
  bool graderCommentsVisibleToGraders;
  bool gradersAnonymousToGraders;
  bool graderNamesVisibleToFinalGrader;
  bool anonymousGrading;
  int allowedAttempts;
  bool postManually;

  Assignment(
      {this.id,
      this.name,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.dueAt,
      this.lockAt,
      this.unlockAt,
      this.hasOverrides,
      this.allDates,
      this.courseId,
      this.htmlUrl,
      this.submissionsDownloadUrl,
      this.assignmentGroupId,
      this.dueDateRequired,
      this.allowedExtensions,
      this.maxNameLength,
      this.turnitinEnabled,
      this.vericiteEnabled,
      this.turnitinSettings,
      this.gradeGroupStudentsIndividually,
      this.externalToolTagAttributes,
      this.peerReviews,
      this.automaticPeerReviews,
      this.peerReviewCount,
      this.peerReviewsAssignAt,
      this.intraGroupPeerReviews,
      this.groupCategoryId,
      this.needsGradingCount,
      this.needsGradingCountBySection,
      this.position,
      this.postToSis,
      this.integrationId,
      this.integrationData,
      this.muted,
      this.pointsPossible,
      this.submissionTypes,
      this.hasSubmittedSubmissions,
      this.gradingType,
      this.gradingStandardId,
      this.published,
      this.unpublishable,
      this.onlyVisibleToOverrides,
      this.lockedForUser,
      this.lockInfo,
      this.lockExplanation,
      this.quizId,
      this.anonymousSubmissions,
      //this.discussionTopic,
      this.freezeOnCopy,
      this.frozen,
      this.frozenAttributes,
      this.submission,
      this.useRubricForGrading,
      this.rubricSettings,
      this.rubric,
      this.assignmentVisibility,
      this.overrides,
      this.omitFromFinalGrade,
      this.moderatedGrading,
      this.graderCount,
      this.finalGraderId,
      this.graderCommentsVisibleToGraders,
      this.gradersAnonymousToGraders,
      this.graderNamesVisibleToFinalGrader,
      this.anonymousGrading,
      this.allowedAttempts,
      this.postManually});

  Assignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dueAt = json['due_at'];
    lockAt = json['lock_at'];
    unlockAt = json['unlock_at'];
    hasOverrides = json['has_overrides'];
    allDates = (json['all_dates'] as List)
        ?.map((i) => AssignmentDate.fromJson(i))
        ?.toList();
    courseId = json['course_id'];
    htmlUrl = json['html_url'];
    submissionsDownloadUrl = json['submissions_download_url'];
    assignmentGroupId = json['assignment_group_id'];
    dueDateRequired = json['due_date_required'];
    allowedExtensions = json['allowed_extensions']?.cast<String>();
    maxNameLength = json['max_name_length'];
    turnitinEnabled = json['turnitin_enabled'];
    vericiteEnabled = json['vericite_enabled'];
    turnitinSettings = json['turnitin_settings'] != null
        ? TurnitinSettings.fromJson(json['turnitin_settings'])
        : null;
    gradeGroupStudentsIndividually = json['grade_group_students_individually'];

    externalToolTagAttributes = json['external_tool_tag_attributes'] != null
        ? ExternalToolTagAttributes.fromJson(
            json['external_tool_tag_attributes'])
        : null;
    peerReviews = json['peer_reviews'];
    automaticPeerReviews = json['automatic_peer_reviews'];
    peerReviewCount = json['peer_review_count'];
    peerReviewsAssignAt = json['peer_reviews_assign_at'];
    intraGroupPeerReviews = json['intra_group_peer_reviews'];
    groupCategoryId = json['group_category_id'];
    needsGradingCount = json['needs_grading_count'];
    if (json['needs_grading_count_by_section'] != null) {
      needsGradingCountBySection = List<NeedsGradingCountBySection>();
      json['needs_grading_count_by_section'].forEach((v) {
        needsGradingCountBySection.add(NeedsGradingCountBySection.fromJson(v));
      });
    }
    position = json['position'];
    postToSis = json['post_to_sis'];
    integrationId = json['integration_id'];
    integrationData = json['integration_data'] != null
        ? IntegrationData.fromJson(json['integration_data'])
        : null;
    muted = json['muted'];
    pointsPossible = json['points_possible'];
    submissionTypes = json['submission_types']?.cast<String>();
    hasSubmittedSubmissions = json['has_submitted_submissions'];
    gradingType = json['grading_type'];
    gradingStandardId = json['grading_standard_id'];
    published = json['published'];
    unpublishable = json['unpublishable'];
    onlyVisibleToOverrides = json['only_visible_to_overrides'];
    lockedForUser = json['locked_for_user'];
    lockInfo = json['lock_info'] != null
        ? LockInfo.fromJson(json['lock_info'])
        : null;
    lockExplanation = json['lock_explanation'];
    quizId = json['quiz_id'];
    anonymousSubmissions = json['anonymous_submissions'];
    //discussionTopic = json['discussion_topic'];
    freezeOnCopy = json['freeze_on_copy'];
    frozen = json['frozen'];
    frozenAttributes = json['frozen_attributes']?.cast<String>();
    submission = json['submission'] != null ? Submission.fromJson(json['submission']) : null;
    useRubricForGrading = json['use_rubric_for_grading'];
    rubricSettings = json['rubric_settings'] != null
        ? RubricSettings.fromJson(json['rubric_settings'])
        : null;
    rubric = (json['rubric'] as List)
        ?.map((i) => RubricCriteria.fromJson(i))
        ?.toList();
    assignmentVisibility = json['assignment_visibility']?.cast<int>();
    overrides = json['overrides'];
    omitFromFinalGrade = json['omit_from_final_grade'];
    moderatedGrading = json['moderated_grading'];
    graderCount = json['grader_count'];
    finalGraderId = json['final_grader_id'];
    graderCommentsVisibleToGraders = json['grader_comments_visible_to_graders'];
    gradersAnonymousToGraders = json['graders_anonymous_to_graders'];
    graderNamesVisibleToFinalGrader =
        json['grader_names_visible_to_final_grader'];
    anonymousGrading = json['anonymous_grading'];
    allowedAttempts = json['allowed_attempts'];
    postManually = json['post_manually'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['due_at'] = this.dueAt;
    data['lock_at'] = this.lockAt;
    data['unlock_at'] = this.unlockAt;
    data['has_overrides'] = this.hasOverrides;
    data['all_dates'] =
        jsonEncode(this.allDates.map((i) => i.toJson()).toList());
    data['course_id'] = this.courseId;
    data['html_url'] = this.htmlUrl;
    data['submissions_download_url'] = this.submissionsDownloadUrl;
    data['assignment_group_id'] = this.assignmentGroupId;
    data['due_date_required'] = this.dueDateRequired;
    data['allowed_extensions'] = this.allowedExtensions;
    data['max_name_length'] = this.maxNameLength;
    data['turnitin_enabled'] = this.turnitinEnabled;
    data['vericite_enabled'] = this.vericiteEnabled;
    data['turnitin_settings'] = this.turnitinSettings.toJson();
    data['grade_group_students_individually'] =
        this.gradeGroupStudentsIndividually;
    data['external_tool_tag_attributes'] =
        this.externalToolTagAttributes.toJson();
    data['peer_reviews'] = this.peerReviews;
    data['automatic_peer_reviews'] = this.automaticPeerReviews;
    data['peer_review_count'] = this.peerReviewCount;
    data['peer_reviews_assign_at'] = this.peerReviewsAssignAt;
    data['intra_group_peer_reviews'] = this.intraGroupPeerReviews;
    data['group_category_id'] = this.groupCategoryId;
    data['needs_grading_count'] = this.needsGradingCount;
    if (this.needsGradingCountBySection != null) {
      data['needs_grading_count_by_section'] =
          this.needsGradingCountBySection.map((v) => v.toJson()).toList();
    }
    data['position'] = this.position;
    data['post_to_sis'] = this.postToSis;
    data['integration_id'] = this.integrationId;
    if (this.integrationData != null) {
      data['integration_data'] = this.integrationData.toJson();
    }
    data['muted'] = this.muted;
    data['points_possible'] = this.pointsPossible;
    data['submission_types'] = this.submissionTypes;
    data['has_submitted_submissions'] = this.hasSubmittedSubmissions;
    data['grading_type'] = this.gradingType;
    data['grading_standard_id'] = this.gradingStandardId;
    data['published'] = this.published;
    data['unpublishable'] = this.unpublishable;
    data['only_visible_to_overrides'] = this.onlyVisibleToOverrides;
    data['locked_for_user'] = this.lockedForUser;
    data['lock_info'] = this.lockInfo.toJson();
    data['lock_explanation'] = this.lockExplanation;
    data['quiz_id'] = this.quizId;
    data['anonymous_submissions'] = this.anonymousSubmissions;
    //data['discussion_topic'] = this.discussionTopic;
    data['freeze_on_copy'] = this.freezeOnCopy;
    data['frozen'] = this.frozen;
    data['frozen_attributes'] = this.frozenAttributes;
    data['submission'] = this.submission;
    data['use_rubric_for_grading'] = this.useRubricForGrading;
    if (this.rubricSettings != null) {
      data['rubric_settings'] = this.rubricSettings.toJson();
    }
    data['rubric'] = jsonEncode(this.rubric.map((i) => i.toJson()).toList());
    data['assignment_visibility'] = this.assignmentVisibility;
    data['overrides'] =
        jsonEncode(this.overrides.map((i) => i.toJson()).toList());
    data['omit_from_final_grade'] = this.omitFromFinalGrade;
    data['moderated_grading'] = this.moderatedGrading;
    data['grader_count'] = this.graderCount;
    data['final_grader_id'] = this.finalGraderId;
    data['grader_comments_visible_to_graders'] =
        this.graderCommentsVisibleToGraders;
    data['graders_anonymous_to_graders'] = this.gradersAnonymousToGraders;
    data['grader_names_visible_to_final_grader'] =
        this.graderNamesVisibleToFinalGrader;
    data['anonymous_grading'] = this.anonymousGrading;
    data['allowed_attempts'] = this.allowedAttempts;
    data['post_manually'] = this.postManually;
    return data;
  }

  bool get isComplete {
    print(
        'evaluating assignment: ${name} lockedForUser: ${lockedForUser}');
    if (submission != null) {
      print(
          'submission is not null. workflowState: "${submission.workflowState}" gradedAt: "${submission.gradedAt}" visible: "${submission.assignmentVisible}"');
      if (submission.workflowState ==
          WorkFlowState.submitted.toShortString() ||
          submission.workflowState ==
              WorkFlowState.graded.toShortString()) {
        return true;
      } else if (submission.gradedAt?.isNotEmpty ?? false) {
        return true;
      } else if (!(submission.assignmentVisible ?? true)) {
        return true;
      }
    }
    if (lockAt != null) {
      print(
          'lockAt: ${lockAt}, is before ${DateTime.now()}? ${DateTime.parse(lockAt).toLocal().isBefore(DateTime.now())}');
      if (DateTime.parse(lockAt).toLocal().isBefore(DateTime.now())) {
        return true;
      }
    } else if (dueAt != null) {
      print(
          'dueAt: ${dueAt}, is before ${DateTime.now()}? ${DateTime.parse(dueAt).toLocal().isBefore(DateTime.now())}');
      if (DateTime.parse(dueAt).toLocal().isBefore(DateTime.now()) &&
          lockedForUser) {
        return true;
      }
    }
    return false;
  }
}

class NeedsGradingCountBySection {
  String sectionId;
  int needsGradingCount;

  NeedsGradingCountBySection({this.sectionId, this.needsGradingCount});

  NeedsGradingCountBySection.fromJson(Map<String, dynamic> json) {
    sectionId = json['section_id'];
    needsGradingCount = json['needs_grading_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section_id'] = this.sectionId;
    data['needs_grading_count'] = this.needsGradingCount;
    return data;
  }
}

class IntegrationData {
  String s5678;

  IntegrationData({this.s5678});

  IntegrationData.fromJson(Map<String, dynamic> json) {
    s5678 = json['5678'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['5678'] = this.s5678;
    return data;
  }
}

class RubricSettings {
  int id;
  String title;
  num pointsPossible;
  bool freeFormCriterionComments;
  bool hideScoreTotal;
  bool hidePoints;

  RubricSettings(
      {this.id,
      this.title,
      this.pointsPossible,
      this.freeFormCriterionComments,
      this.hideScoreTotal,
      this.hidePoints});

  RubricSettings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    pointsPossible = json['points_possible'];
    freeFormCriterionComments = json['free_form_criterion_comments'];
    hideScoreTotal = json['hide_score_total'];
    hidePoints = json['hide_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['points_possible'] = this.pointsPossible;
    data['free_form_criterion_comments'] = this.freeFormCriterionComments;
    data['hide_score_total'] = this.hideScoreTotal;
    data['hide_points'] = this.hidePoints;
    return data;
  }
}
