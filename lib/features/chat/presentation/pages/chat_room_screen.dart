import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';
import '../widgets/chat_image_bubble.dart';
import '../../domain/entities/message.dart';

class ChatRoomScreen extends StatelessWidget {
  final String userId;
  final String userName;
  final String? userAvatar;

  const ChatRoomScreen({
    super.key,
    required this.userId,
    required this.userName,
    this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc()..add(LoadChats()),
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          final isDark = theme.brightness == Brightness.dark;

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            extendBody: false,
            appBar: AppBar(
              leading: PlatformBackButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundImage:
                        userAvatar != null ? NetworkImage(userAvatar!) : null,
                    child: userAvatar == null
                        ? Icon(EneftyIcons.user_outline, size: 20.sp)
                        : null,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    userName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 16.sp,
                      color:
                          isDark ? AppColors.neutral50 : AppColors.neutral900,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    EneftyIcons.more_circle_outline,
                    color: isDark ? AppColors.neutral50 : AppColors.neutral900,
                  ),
                  onPressed: () {
                    // Show chat options
                  },
                ),
              ],
            ),
            body: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ChatError) {
                  return Center(child: Text(state.message));
                }

                if (state is ChatLoaded) {
                  return SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            itemCount: state.chats.length,
                            itemBuilder: (context, index) {
                              final message = state.chats[index];
                              final isMe = message.senderId == userId;

                              if (message.type == MessageType.image) {
                                return ChatImageBubble(
                                    message: message, isMe: isMe);
                              }

                              return ChatBubble(message: message, isMe: isMe);
                            },
                          ),
                        ),
                        ChatInput(
                          onSend: (content) {
                            context.read<ChatBloc>().add(
                                  SendMessage(
                                      content: content, receiverId: userId),
                                );
                          },
                          onAttachment: () {
                            // TODO: Implement attachment picker
                          },
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
