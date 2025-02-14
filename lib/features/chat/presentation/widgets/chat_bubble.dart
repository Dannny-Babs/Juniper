import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/entities/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 4.h,
        ),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isMe
              ? AppColors.primary500
              : isDark
                  ? AppColors.surfaceDark
                  : AppColors.neutral100,
          borderRadius: BorderRadius.circular(12.r),
        ),
        constraints: BoxConstraints(maxWidth: 0.7.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isMe ? Colors.white : theme.textTheme.bodyMedium?.color,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              _formatTime(message.timestamp),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isMe
                    ? Colors.white.withOpacity(0.7)
                    : theme.textTheme.bodySmall?.color,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}
