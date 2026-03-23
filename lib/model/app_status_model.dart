class InvitatyAppStatus {
  final String version;
  final int status;

  const InvitatyAppStatus({
    required this.version,
    required this.status,
  });

  factory InvitatyAppStatus.fromJson(Map<String, dynamic> json) {
    return InvitatyAppStatus(
      version: (json['version'] as String?) ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
    );
  }
}

