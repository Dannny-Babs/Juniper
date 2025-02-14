import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<LoadChats>(_onLoadChats);
    on<SendMessage>(_onSendMessage);
    on<MarkAsRead>(_onMarkAsRead);
  }

  final _mockMessages = [
    Message(
      id: '1',
      content: "Hi, I'm interested in the property on 123 Main Street",
      senderId: 'user1',
      roomId: 'room1',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    Message(
      id: '2',
      content:
          "Great! The property is still available. Would you like to schedule a viewing?",
      senderId: 'agent1',
      roomId: 'room1',
      timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
    ),
  ];

  Future<void> _onLoadChats(LoadChats event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      await Future.delayed(
          const Duration(milliseconds: 500)); // Simulate network delay
      emit(ChatLoaded(_mockMessages));
    } catch (e) {
      emit(const ChatError('Failed to load messages'));
    }
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    try {
      final message = Message(
        id: DateTime.now().toString(),
        content: event.content,
        senderId: 'user1', // Replace with actual user ID
        roomId: 'room1',
        timestamp: DateTime.now(),
      );

      if (state is ChatLoaded) {
        final currentMessages = (state as ChatLoaded).chats;
        emit(ChatLoaded([message, ...currentMessages]));
      }
    } catch (e) {
      emit(const ChatError('Failed to send message'));
    }
  }

  Future<void> _onMarkAsRead(MarkAsRead event, Emitter<ChatState> emit) async {
    // Implement mark as read logic
  }
}
