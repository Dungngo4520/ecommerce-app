import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String content;
  final Timestamp timestamp;
  final String senderId;

  ChatMessage({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.senderId,
  });

  ChatMessage copyWith({
    String? id,
    String? content,
    Timestamp? timestamp,
    String? senderId,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      senderId: senderId ?? this.senderId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'timestamp': timestamp,
      'senderId': senderId,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'],
      content: map['content'],
      timestamp: map['timestamp'],
      senderId: map['senderId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) => ChatMessage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatMessage(id: $id, content: $content, timestamp: $timestamp, senderId: $senderId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatMessage &&
        other.id == id &&
        other.content == content &&
        other.timestamp == timestamp &&
        other.senderId == senderId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ content.hashCode ^ timestamp.hashCode ^ senderId.hashCode;
  }
}
