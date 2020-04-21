class Term {
  int id;
  String name;
  String startAt;
  String endAt;

  Term({this.id, this.name, this.startAt, this.endAt});

  Term.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startAt = json['start_at'];
    endAt = json['end_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    return data;
  }
}
