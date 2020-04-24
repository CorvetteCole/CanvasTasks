class SubmissionComment {
  int id;
  int authorId;
  String authorName;
  String author;
  String comment;
  String createdAt;
  String editedAt;
  Null mediaComment;

  SubmissionComment(
      {this.id,
        this.authorId,
        this.authorName,
        this.author,
        this.comment,
        this.createdAt,
        this.editedAt,
        this.mediaComment});

  SubmissionComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorId = json['author_id'];
    authorName = json['author_name'];
    author = json['author'];
    comment = json['comment'];
    createdAt = json['created_at'];
    editedAt = json['edited_at'];
    mediaComment = json['media_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author_id'] = this.authorId;
    data['author_name'] = this.authorName;
    data['author'] = this.author;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['edited_at'] = this.editedAt;
    data['media_comment'] = this.mediaComment;
    return data;
  }
}
