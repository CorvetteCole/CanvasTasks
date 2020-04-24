class MediaComment {
  String contentType;
  String displayName;
  String mediaId;
  String mediaType;
  String url;

  MediaComment(
      {this.contentType,
        this.displayName,
        this.mediaId,
        this.mediaType,
        this.url});

  MediaComment.fromJson(Map<String, dynamic> json) {
    contentType = json['content-type'];
    displayName = json['display_name'];
    mediaId = json['media_id'];
    mediaType = json['media_type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content-type'] = this.contentType;
    data['display_name'] = this.displayName;
    data['media_id'] = this.mediaId;
    data['media_type'] = this.mediaType;
    data['url'] = this.url;
    return data;
  }
}
