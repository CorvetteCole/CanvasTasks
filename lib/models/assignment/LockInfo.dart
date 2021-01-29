class LockInfo {
  String assetString;
  String unlockAt;
  String lockAt;
  String contextModule;
  bool manuallyLocked;
  bool canView;

  LockInfo(
      {this.assetString,
        this.unlockAt,
        this.lockAt,
        this.contextModule,
        this.manuallyLocked,
      this.canView});

  LockInfo.fromJson(Map<String, dynamic> json) {
    assetString = json['asset_string'];
    unlockAt = json['unlock_at'];
    lockAt = json['lock_at'];
    manuallyLocked = json['manually_locked'];
    canView = json['can_view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asset_string'] = assetString;
    data['unlock_at'] = unlockAt;
    data['lock_at'] = lockAt;
    data['manually_locked'] = manuallyLocked;
    data['can_view'] = canView;
    return data;
  }
}