class ExternalToolTagAttributes {
  String url;
  bool newTab;
  String resourceLinkId;

  ExternalToolTagAttributes({this.url, this.newTab, this.resourceLinkId});

  ExternalToolTagAttributes.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    newTab = json['new_tab'];
    resourceLinkId = json['resource_link_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['new_tab'] = this.newTab;
    data['resource_link_id'] = this.resourceLinkId;
    return data;
  }
}