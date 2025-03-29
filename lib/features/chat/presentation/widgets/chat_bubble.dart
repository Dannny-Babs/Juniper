import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/entities/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isReceiver;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isReceiver,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: BubbleSpecialThree(
        text: message.content,
        color: !isReceiver
            ? AppColors.primary500
            : isDark
                ? AppColors.surfaceDark
                : AppColors.primary100,
        tail: true,
        isSender: !isReceiver,
        delivered: !isReceiver && message.isRead,
        sent: !isReceiver && message.status == MessageStatus.sent,
        seen: !isReceiver && message.status == MessageStatus.read,
        textStyle: theme.textTheme.bodyMedium!.copyWith(
          color: !isReceiver ? Colors.white : theme.textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}
