class AssignmentDate {
  int id;
  bool base;
  String title;
  String dueAt;
  String unlockAt;
  String lockAt;

  AssignmentDate(
      {this.id, this.base, this.title, this.dueAt, this.unlockAt, this.lockAt});

  AssignmentDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    base = json['base'];
    title = json['title'];
    dueAt = json['due_at'];
    unlockAt = json['unlock_at'];
    lockAt = json['lock_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['base'] = this.base;
    data['title'] = this.title;
    data['due_at'] = this.dueAt;
    data['unlock_at'] = this.unlockAt;
    data['lock_at'] = this.lockAt;
    return data;
  }
}
