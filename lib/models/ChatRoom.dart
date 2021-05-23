import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatRoom {
  final String id;
  final String lastMessage;
  final Timestamp lastMessageTimestamp;
  final List<String> users;

  ChatRoom({
    required this.id,
    required this.lastMessage,
    required this.lastMessageTimestamp,
    required this.users,
  });

  ChatRoom copyWith({
    String? id,
    String? lastMessage,
    Timestamp? lastMessageTimestamp,
    List<String>? users,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lastMessage': lastMessage,
      'lastMessageTimestamp': lastMessageTimestamp,
      'users': users,
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'],
      lastMessage: map['lastMessage'],
      lastMessageTimestamp: map['lastMessageTimestamp'],
      users: List<String>.from(map['users']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoom.fromJson(String source) => ChatRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatRoom(id: $id, lastMessage: $lastMessage, lastMessageTimestamp: $lastMessageTimestamp, users: $users)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatRoom &&
        other.id == id &&
        other.lastMessage == lastMessage &&
        other.lastMessageTimestamp == lastMessageTimestamp &&
        listEquals(other.users, users);
  }

  @override
  int get hashCode {
    return id.hashCode ^ lastMessage.hashCode ^ lastMessageTimestamp.hashCode ^ users.hashCode;
  }
}
