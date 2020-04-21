class CourseProgress {
  int requirementCount;
  int requirementCompletedCount;
  String nextRequirementUrl;
  String completedAt;

  CourseProgress(
      {this.requirementCount,
        this.requirementCompletedCount,
        this.nextRequirementUrl,
        this.completedAt});

  CourseProgress.fromJson(Map<String, dynamic> json) {
    requirementCount = json['requirement_count'];
    requirementCompletedCount = json['requirement_completed_count'];
    nextRequirementUrl = json['next_requirement_url'];
    completedAt = json['completed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requirement_count'] = this.requirementCount;
    data['requirement_completed_count'] = this.requirementCompletedCount;
    data['next_requirement_url'] = this.nextRequirementUrl;
    data['completed_at'] = this.completedAt;
    return data;
  }
}
