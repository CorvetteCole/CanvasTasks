import 'dart:convert';

import 'package:CanvasTasks/models/assignment/RubricRating.dart';

class RubricCriteria {
  num points;
  String id;
  String learningOutcomeId;
  String vendorGuid;
  String description;
  String longDescription;
  bool criterionUseRange;
  List<RubricRating> ratings;
  bool ignoreForScoring;

  RubricCriteria(
      {this.points,
        this.id,
        this.learningOutcomeId,
        this.vendorGuid,
        this.description,
        this.longDescription,
        this.criterionUseRange,
        this.ratings,
        this.ignoreForScoring});

  RubricCriteria.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    id = json['id'];
    learningOutcomeId = json['learning_outcome_id'];
    vendorGuid = json['vendor_guid'];
    description = json['description'];
    longDescription = json['long_description'];
    criterionUseRange = json['criterion_use_range'];
    ratings = (json['ratings'] as List).map((i) => RubricRating.fromJson(i)).toList();
    ignoreForScoring = json['ignore_for_scoring'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    data['id'] = this.id;
    data['learning_outcome_id'] = this.learningOutcomeId;
    data['vendor_guid'] = this.vendorGuid;
    data['description'] = this.description;
    data['long_description'] = this.longDescription;
    data['criterion_use_range'] = this.criterionUseRange;
    data['ratings'] = jsonEncode(this.ratings.map((i) => i.toJson()).toList());
    data['ignore_for_scoring'] = this.ignoreForScoring;
    return data;
  }
}
