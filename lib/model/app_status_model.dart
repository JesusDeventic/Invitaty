class FilmaniakAppStatus {
  final String version;
  final int status;

  const FilmaniakAppStatus({
    required this.version,
    required this.status,
  });

  factory FilmaniakAppStatus.fromJson(Map<String, dynamic> json) {
    return FilmaniakAppStatus(
      version: (json['version'] as String?) ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
    );
  }
}

