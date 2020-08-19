import 'package:CanvasTasks/models/course/course_progress.dart';
import 'package:CanvasTasks/models/course/term.dart';

class Course {
  int id;
  String sisCourseId;
  String uuid;
  String integrationId;
  int sisImportId;
  String name;
  String courseCode;
  String workflowState;
  int accountId;
  int rootAccountId;
  int enrollmentTermId;
  int gradingStandardId;
  String gradePassbackSetting;
  String createdAt;
  String startAt;
  String endAt;
  String locale;

  //Null enrollments; Enrollment object, not implemented
  int totalStudents;

  //Null calendar;
  String defaultView;
  String syllabusBody;
  int needsGradingCount;
  Term term;
  CourseProgress courseProgress;
  bool applyAssignmentGroupWeights;
  Permissions permissions;
  bool isPublic;
  bool isPublicToAuthUsers;
  bool publicSyllabus;
  bool publicSyllabusToAuth;
  String publicDescription;
  int storageQuotaMb;
  int storageQuotaUsedMb;
  bool hideFinalGrades;
  String license;
  bool allowStudentAssignmentEdits;
  bool allowWikiComments;
  bool allowStudentForumAttachments;
  bool openEnrollment;
  bool selfEnrollment;
  bool restrictEnrollmentsToCourseDates;
  String courseFormat;
  bool accessRestrictedByDate;
  String timeZone;
  bool blueprint;
  BlueprintRestrictions blueprintRestrictions;
  BlueprintRestrictionsByObjectType blueprintRestrictionsByObjectType;
  bool isFavorite;
  bool isConcluded;

  String get courseCodeTruncated {
    var truncated = '';
    if (!RegExp(r'[0-9]')
        .hasMatch(courseCode.trim().substring(0, 3))) {
      // handle 3 letter course codes
      truncated = courseCode.trim().substring(0, 6);
    } else {
      truncated = courseCode.trim().substring(0, 5);
    }
    print('full course code: $courseCode, truncated: $truncated');
    return truncated;
  }

  Course(
      {this.id,
      this.sisCourseId,
      this.uuid,
      this.integrationId,
      this.sisImportId,
      this.name,
      this.courseCode,
      this.workflowState,
      this.accountId,
      this.rootAccountId,
      this.enrollmentTermId,
      this.gradingStandardId,
      this.gradePassbackSetting,
      this.createdAt,
      this.startAt,
      this.endAt,
      this.locale,
      //this.enrollments,
      this.totalStudents,
      //this.calendar,
      this.defaultView,
      this.syllabusBody,
      this.needsGradingCount,
      this.term,
      this.courseProgress,
      this.applyAssignmentGroupWeights,
      this.permissions,
      this.isPublic,
      this.isPublicToAuthUsers,
      this.publicSyllabus,
      this.publicSyllabusToAuth,
      this.publicDescription,
      this.storageQuotaMb,
      this.storageQuotaUsedMb,
      this.hideFinalGrades,
      this.license,
      this.allowStudentAssignmentEdits,
      this.allowWikiComments,
      this.allowStudentForumAttachments,
      this.openEnrollment,
      this.selfEnrollment,
      this.restrictEnrollmentsToCourseDates,
      this.courseFormat,
      this.accessRestrictedByDate,
      this.timeZone,
      this.blueprint,
      this.blueprintRestrictions,
      this.blueprintRestrictionsByObjectType,
      this.isFavorite,
      this.isConcluded});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sisCourseId = json['sis_course_id'];
    uuid = json['uuid'];
    integrationId = json['integration_id'];
    sisImportId = json['sis_import_id'];
    name = json['name'];
    courseCode = json['course_code'];
    workflowState = json['workflow_state'];
    accountId = json['account_id'];
    rootAccountId = json['root_account_id'];
    enrollmentTermId = json['enrollment_term_id'];
    gradingStandardId = json['grading_standard_id'];
    gradePassbackSetting = json['grade_passback_setting'];
    createdAt = json['created_at'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    locale = json['locale'];
    //enrollments = json['enrollments'];
    totalStudents = json['total_students'];
    //calendar = json['calendar'];
    defaultView = json['default_view'];
    syllabusBody = json['syllabus_body'];
    needsGradingCount = json['needs_grading_count'];
    term = json['term'] != null ? Term.fromJson(json['term']) : null;
    courseProgress = json['course_progress'] != null
        ? new CourseProgress.fromJson(json['course_progress'])
        : null;
    applyAssignmentGroupWeights = json['apply_assignment_group_weights'];
    permissions = json['permissions'] != null
        ? new Permissions.fromJson(json['permissions'])
        : null;
    isPublic = json['is_public'];
    isPublicToAuthUsers = json['is_public_to_auth_users'];
    publicSyllabus = json['public_syllabus'];
    publicSyllabusToAuth = json['public_syllabus_to_auth'];
    publicDescription = json['public_description'];
    storageQuotaMb = json['storage_quota_mb'];
    storageQuotaUsedMb = json['storage_quota_used_mb'];
    hideFinalGrades = json['hide_final_grades'];
    license = json['license'];
    allowStudentAssignmentEdits = json['allow_student_assignment_edits'];
    allowWikiComments = json['allow_wiki_comments'];
    allowStudentForumAttachments = json['allow_student_forum_attachments'];
    openEnrollment = json['open_enrollment'];
    selfEnrollment = json['self_enrollment'];
    restrictEnrollmentsToCourseDates =
        json['restrict_enrollments_to_course_dates'];
    courseFormat = json['course_format'];
    accessRestrictedByDate = json['access_restricted_by_date'];
    timeZone = json['time_zone'];
    blueprint = json['blueprint'];
    blueprintRestrictions = json['blueprint_restrictions'] != null
        ? new BlueprintRestrictions.fromJson(json['blueprint_restrictions'])
        : null;
    blueprintRestrictionsByObjectType =
        json['blueprint_restrictions_by_object_type'] != null
            ? new BlueprintRestrictionsByObjectType.fromJson(
                json['blueprint_restrictions_by_object_type'])
            : null;
    isFavorite = json['is_favorite'];
    isConcluded = json['concluded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sis_course_id'] = this.sisCourseId;
    data['uuid'] = this.uuid;
    data['integration_id'] = this.integrationId;
    data['sis_import_id'] = this.sisImportId;
    data['name'] = this.name;
    data['course_code'] = this.courseCode;
    data['workflow_state'] = this.workflowState;
    data['account_id'] = this.accountId;
    data['root_account_id'] = this.rootAccountId;
    data['enrollment_term_id'] = this.enrollmentTermId;
    data['grading_standard_id'] = this.gradingStandardId;
    data['grade_passback_setting'] = this.gradePassbackSetting;
    data['created_at'] = this.createdAt;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['locale'] = this.locale;
    //data['enrollments'] = this.enrollments;
    data['total_students'] = this.totalStudents;
    //data['calendar'] = this.calendar;
    data['default_view'] = this.defaultView;
    data['syllabus_body'] = this.syllabusBody;
    data['needs_grading_count'] = this.needsGradingCount;
    data['term'] = this.term.toJson();
    data['course_progress'] = this.courseProgress.toJson();
    data['apply_assignment_group_weights'] = this.applyAssignmentGroupWeights;
    if (this.permissions != null) {
      data['permissions'] = this.permissions.toJson();
    }
    data['is_public'] = this.isPublic;
    data['is_public_to_auth_users'] = this.isPublicToAuthUsers;
    data['public_syllabus'] = this.publicSyllabus;
    data['public_syllabus_to_auth'] = this.publicSyllabusToAuth;
    data['public_description'] = this.publicDescription;
    data['storage_quota_mb'] = this.storageQuotaMb;
    data['storage_quota_used_mb'] = this.storageQuotaUsedMb;
    data['hide_final_grades'] = this.hideFinalGrades;
    data['license'] = this.license;
    data['allow_student_assignment_edits'] = this.allowStudentAssignmentEdits;
    data['allow_wiki_comments'] = this.allowWikiComments;
    data['allow_student_forum_attachments'] = this.allowStudentForumAttachments;
    data['open_enrollment'] = this.openEnrollment;
    data['self_enrollment'] = this.selfEnrollment;
    data['restrict_enrollments_to_course_dates'] =
        this.restrictEnrollmentsToCourseDates;
    data['course_format'] = this.courseFormat;
    data['access_restricted_by_date'] = this.accessRestrictedByDate;
    data['time_zone'] = this.timeZone;
    data['blueprint'] = this.blueprint;
    if (this.blueprintRestrictions != null) {
      data['blueprint_restrictions'] = this.blueprintRestrictions.toJson();
    }
    if (this.blueprintRestrictionsByObjectType != null) {
      data['blueprint_restrictions_by_object_type'] =
          this.blueprintRestrictionsByObjectType.toJson();
    }
    data['is_favorite'] = this.isFavorite;
    data['concluded'] = this.isConcluded;
    return data;
  }
}

class Permissions {
  bool createDiscussionTopic;
  bool createAnnouncement;

  Permissions({this.createDiscussionTopic, this.createAnnouncement});

  Permissions.fromJson(Map<String, dynamic> json) {
    createDiscussionTopic = json['create_discussion_topic'];
    createAnnouncement = json['create_announcement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_discussion_topic'] = this.createDiscussionTopic;
    data['create_announcement'] = this.createAnnouncement;
    return data;
  }
}

class BlueprintRestrictions {
  bool content;
  bool points;
  bool dueDates;
  bool availabilityDates;

  BlueprintRestrictions(
      {this.content, this.points, this.dueDates, this.availabilityDates});

  BlueprintRestrictions.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    points = json['points'];
    dueDates = json['due_dates'];
    availabilityDates = json['availability_dates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['points'] = this.points;
    data['due_dates'] = this.dueDates;
    data['availability_dates'] = this.availabilityDates;
    return data;
  }
}

class BlueprintRestrictionsByObjectType {
  BlueprintAssignment assignment;
  WikiPage wikiPage;

  BlueprintRestrictionsByObjectType({this.assignment, this.wikiPage});

  BlueprintRestrictionsByObjectType.fromJson(Map<String, dynamic> json) {
    assignment = json['assignment'] != null
        ? new BlueprintAssignment.fromJson(json['assignment'])
        : null;
    wikiPage = json['wiki_page'] != null
        ? new WikiPage.fromJson(json['wiki_page'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.assignment != null) {
      data['assignment'] = this.assignment.toJson();
    }
    if (this.wikiPage != null) {
      data['wiki_page'] = this.wikiPage.toJson();
    }
    return data;
  }
}

class BlueprintAssignment {
  bool content;
  bool points;

  BlueprintAssignment({this.content, this.points});

  BlueprintAssignment.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['points'] = this.points;
    return data;
  }
}

class WikiPage {
  bool content;

  WikiPage({this.content});

  WikiPage.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    return data;
  }
}
