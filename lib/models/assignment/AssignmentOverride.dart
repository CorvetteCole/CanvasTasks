class AssignmentOverride {
  int id;
  int assignmentId;
  List<int> studentIds;
  int groupId;
  int courseSectionId;
  String title;
  String dueAt;
  bool allDay;
  String allDayDate;
  String unlockAt;
  String lockAt;

  AssignmentOverride(
      {this.id,
        this.assignmentId,
        this.studentIds,
        this.groupId,
        this.courseSectionId,
        this.title,
        this.dueAt,
        this.allDay,
        this.allDayDate,
        this.unlockAt,
        this.lockAt});

  AssignmentOverride.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignmentId = json['assignment_id'];
    studentIds = json['student_ids'].cast<int>();
    groupId = json['group_id'];
    courseSectionId = json['course_section_id'];
    title = json['title'];
    dueAt = json['due_at'];
    allDay = json['all_day'];
    allDayDate = json['all_day_date'];
    unlockAt = json['unlock_at'];
    lockAt = json['lock_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assignment_id'] = this.assignmentId;
    data['student_ids'] = this.studentIds;
    data['group_id'] = this.groupId;
    data['course_section_id'] = this.courseSectionId;
    data['title'] = this.title;
    data['due_at'] = this.dueAt;
    data['all_day'] = this.allDay;
    data['all_day_date'] = this.allDayDate;
    data['unlock_at'] = this.unlockAt;
    data['lock_at'] = this.lockAt;
    return data;
  }
}
