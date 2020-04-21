class RubricRating {
  num points;
  String id;
  String description;
  String longDescription;

  RubricRating({this.points, this.id, this.description, this.longDescription});

  RubricRating.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    id = json['id'];
    description = json['description'];
    longDescription = json['long_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    data['id'] = this.id;
    data['description'] = this.description;
    data['long_description'] = this.longDescription;
    return data;
  }
}
