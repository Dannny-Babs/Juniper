import 'package:equatable/equatable.dart';
import '../../domain/entities/message.dart';

class ChatMessage extends Equatable {
  final String id;
  final String content;
  final String senderId;
  final String receiverId;
  final String? imageUrl;
  final DateTime timestamp;
  final bool isRead;
  final MessageStatus status;
  final MessageType type;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.senderId,
    required this.receiverId,
    this.imageUrl,
    required this.timestamp,
    this.isRead = false,
    this.status = MessageStatus.sent,
    this.type = MessageType.text,
  });

  @override
  List<Object?> get props => [
        id,
        content,
        senderId,
        receiverId,
        imageUrl,
        timestamp,
        isRead,
        status,
        type,
      ];
}

enum MessageStatus { sending, sent, delivered, read, failed }
