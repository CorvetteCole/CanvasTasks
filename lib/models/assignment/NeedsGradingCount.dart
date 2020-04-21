class NeedsGradingCount {
  String sectionId;
  int needsGradingCount;

  NeedsGradingCount({this.sectionId, this.needsGradingCount});

  NeedsGradingCount.fromJson(Map<String, dynamic> json) {
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
