part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadChats extends ChatEvent {}

class SendMessage extends ChatEvent {
  final String content;
  final String receiverId;

  const SendMessage({
    required this.content,
    required this.receiverId,
  });

  @override
  List<Object?> get props => [content, receiverId];
}

class MarkAsRead extends ChatEvent {
  final String messageId;

  const MarkAsRead(this.messageId);

  @override
  List<Object?> get props => [messageId];
}
