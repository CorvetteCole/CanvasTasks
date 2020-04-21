class TurnitinSettings {
  String originalityReportVisibility;
  bool sPaperCheck;
  bool internetCheck;
  bool journalCheck;
  bool excludeBiblio;
  bool excludeQuoted;
  String excludeSmallMatchesType;
  int excludeSmallMatchesValue;

  TurnitinSettings(
      {this.originalityReportVisibility,
        this.sPaperCheck,
        this.internetCheck,
        this.journalCheck,
        this.excludeBiblio,
        this.excludeQuoted,
        this.excludeSmallMatchesType,
        this.excludeSmallMatchesValue});

  TurnitinSettings.fromJson(Map<String, dynamic> json) {
    originalityReportVisibility = json['originality_report_visibility'];
    sPaperCheck = json['s_paper_check'];
    internetCheck = json['internet_check'];
    journalCheck = json['journal_check'];
    excludeBiblio = json['exclude_biblio'];
    excludeQuoted = json['exclude_quoted'];
    excludeSmallMatchesType = json['exclude_small_matches_type'];
    excludeSmallMatchesValue = json['exclude_small_matches_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originality_report_visibility'] = this.originalityReportVisibility;
    data['s_paper_check'] = this.sPaperCheck;
    data['internet_check'] = this.internetCheck;
    data['journal_check'] = this.journalCheck;
    data['exclude_biblio'] = this.excludeBiblio;
    data['exclude_quoted'] = this.excludeQuoted;
    data['exclude_small_matches_type'] = this.excludeSmallMatchesType;
    data['exclude_small_matches_value'] = this.excludeSmallMatchesValue;
    return data;
  }
}
