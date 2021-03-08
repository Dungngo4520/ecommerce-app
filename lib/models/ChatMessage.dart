import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isSender;

  ChatMessage({
    this.text,
    @required this.isSender,
  });
}

List demeChatMessages = [
  ChatMessage(
    text: "Hi Sajol,",
    isSender: false,
  ),
  ChatMessage(
    text: "Hello, How are you?",
    isSender: true,
  ),
  ChatMessage(
    text: "Hey",
    isSender: false,
  ),
  ChatMessage(
    text: "What's up?",
    isSender: true,
  ),
  ChatMessage(
    text: "Error happend",
    isSender: true,
  ),
  ChatMessage(
    text: "This looks great man!!",
    isSender: false,
  ),
  ChatMessage(
    text: "Glad you like it",
    isSender: true,
  ),
];
