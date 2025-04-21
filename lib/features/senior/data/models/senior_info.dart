class SeniorInfo {
  final String name;
  final String nationality;
  final bool hasWrittenBasicInfo;

  SeniorInfo({
    required this.name,
    required this.nationality,
    required this.hasWrittenBasicInfo,
  });

  factory SeniorInfo.fromJson(Map<String, dynamic> json) {
    return SeniorInfo(
      name: json['name'] ?? '',
      nationality: json['nationality'] ?? '',
      hasWrittenBasicInfo: json['hasWrittenBasicInfo'] ?? false,
    );
  }
}
