// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  String? uid;
  String message;
  String? senderUid;
  String recieverUid;
  
  MessageModel({
    this.uid,
    required this.message,
    this.senderUid,
    required this.recieverUid,
    required String receiverUid,
  });

  MessageModel copyWith({
    String? uid,
    String? message,
    String? senderUid,
    String? recieverUid,
  }) {
    return MessageModel(
      uid: uid ?? this.uid,
      message: message ?? this.message,
      senderUid: senderUid ?? this.senderUid,
      recieverUid: recieverUid ?? this.recieverUid, receiverUid: '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'message': message,
      'senderUid': senderUid,
      'recieverUid': recieverUid,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      message: map['message'] as String,
      senderUid: map['senderUid'] != null ? map['senderUid'] as String : null,
      recieverUid: map['recieverUid'] as String, receiverUid: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(uid: $uid, message: $message, senderUid: $senderUid, recieverUid: $recieverUid)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid && other.message == message && other.senderUid == senderUid && other.recieverUid == recieverUid;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ message.hashCode ^ senderUid.hashCode ^ recieverUid.hashCode;
  }
}
