import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/optimized_image.dart';
import '../../data/models/chat_message.dart';

class ChatRoomCard extends StatelessWidget {
  final ChatMessage room;
  final VoidCallback? onTap;

  const ChatRoomCard({
    super.key,
    required this.room,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundImage:
                  room.imageUrl != null ? NetworkImage(room.imageUrl!) : null,
              child: room.imageUrl == null
                  ? Icon(EneftyIcons.user_outline, size: 24.sp)
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        room.receiverId, // Replace with actual name
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 16.sp,
                          color: isDark
                              ? AppColors.neutral50
                              : AppColors.neutral900,
                        ),
                      ),
                      Text(
                        _formatTime(room.timestamp),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.neutral400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    room.content,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutral400,
                      fontSize: 14.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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
