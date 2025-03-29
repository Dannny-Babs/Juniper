import 'package:equatable/equatable.dart';

enum MessageType { text, image, document, location }

enum MessageStatus { sending, sent, delivered, read, failed }

class Message extends Equatable {
  final String id;
  final String content;
  final String senderId;
  final String roomId;
  final DateTime timestamp;
  final bool isRead;
  final MessageType type;
  final MessageStatus status;
  final String? imageUrl;

  const Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.roomId,
    required this.timestamp,
    this.isRead = false,
    this.type = MessageType.text,
    this.status = MessageStatus.sent,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        content,
        senderId,
        roomId,
        timestamp,
        isRead,
        type,
        status,
        imageUrl,
      ];
}
