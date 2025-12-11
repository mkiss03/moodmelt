class MicrotherapySession {
  final String moduleId;
  final DateTime timestamp;
  final Map<String, dynamic> data;

  MicrotherapySession({
    required this.moduleId,
    required this.timestamp,
    required this.data,
  });

  factory MicrotherapySession.fromJson(Map<String, dynamic> json) {
    return MicrotherapySession(
      moduleId: json['moduleId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      data: json['data'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'moduleId': moduleId,
      'timestamp': timestamp.toIso8601String(),
      'data': data,
    };
  }
}

enum StressBalloonState {
  idle,
  inputting,
  loading,
  result,
  error,
}
