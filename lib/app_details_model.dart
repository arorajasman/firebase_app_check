class AppDetailsModel {
  final int priority;
  final String androidLastMinimumUpdateVersion;
  final String iOSLastMinimumUpdateVersion;
  final String currentIOSVersion;

  const AppDetailsModel({
    this.priority = 0,
    this.androidLastMinimumUpdateVersion = "",
    this.currentIOSVersion = "",
    this.iOSLastMinimumUpdateVersion = "",
  });

  factory AppDetailsModel.fromJSON(Map<String, dynamic> json) =>
      AppDetailsModel(
        priority: json['priority'] ?? 0,
        androidLastMinimumUpdateVersion:
            json['lastMinimumUpdateVersion']['android'] ?? "",
        iOSLastMinimumUpdateVersion:
            json['lastMinimumUpdateVersion']['iOS'] ?? "",
        currentIOSVersion: json['currentIOSVersion'] ?? "",
      );

  Map<String, dynamic> toJSON() => {
        "priority": priority,
        "androidLastMinimumUpdateVersion": androidLastMinimumUpdateVersion,
        "iOSLastMinimumUpdateVersion": iOSLastMinimumUpdateVersion,
        "currentIOSVersion": currentIOSVersion,
      };
}
