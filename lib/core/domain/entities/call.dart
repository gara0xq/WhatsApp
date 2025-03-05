class Call {
  final String callId;
  final String callerId;
  final String receiverId;
  final DateTime startTime;
  final DateTime? endTime;
  final String callType;
  final bool isMissed;

  Call({
    required this.callId,
    required this.callerId,
    required this.receiverId,
    required this.startTime,
    this.endTime,
    required this.callType,
    this.isMissed = false,
  });
}
