import '../../domain/entities/call.dart';

class CallModel extends Call {
  CallModel({
    required super.callId,
    required super.callerId,
    required super.receiverId,
    required super.startTime,
    super.endTime,
    required super.callType,
    super.isMissed,
  });

  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      callId: map['call_id'],
      callerId: map['caller_id'],
      receiverId: map['receiver_id'],
      startTime: DateTime.parse(map['start_time']),
      endTime: map['end_time'] != null ? DateTime.parse(map['end_time']) : null,
      callType: map['call_type'],
      isMissed: map['is_missed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'call_id': callId,
      'caller_id': callerId,
      'receiver_id': receiverId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'call_type': callType,
      'is_missed': isMissed,
    };
  }
}
