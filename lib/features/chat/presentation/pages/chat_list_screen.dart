import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../bloc/chat_bloc.dart';
import 'chat_room_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc()..add(LoadChats()),
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          final isDark = theme.brightness == Brightness.dark;

          // Typed placeholder chats
          final List<Map<String, dynamic>> chats = [
            {
              'name': 'John Smith',
              'message': 'Is the property still available?',
              'time': '10:30 AM',
              'unread': 2,
              'avatar':
                  'https://i.pravatar.cc/150?img=1' // Using placeholder avatar
            },
            {
              'name': 'Sarah Wilson',
              'message': 'When can I schedule a viewing?',
              'time': 'Yesterday',
              'unread': 0,
              'avatar': null
            },
            // Add more placeholder chats
          ];

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text(
                'Chat',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.neutral800,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: isDark
                              ? AppColors.neutral800
                              : AppColors.neutral200,
                          width: 1),
                    ),
                    minimumSize: Size.zero,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {},
                  child: SvgPicture.asset(
                    'assets/icons/Menu Dots.svg',
                    color: isDark ? AppColors.neutral300 : AppColors.neutral500,
                    height: 22.sp,
                  ),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 24.r,
                    backgroundImage: chat['avatar'] != null
                        ? NetworkImage(
                            chat['avatar'] as String) // Changed to NetworkImage
                        : null,
                    child: chat['avatar'] == null
                        ? Icon(EneftyIcons.user_outline, size: 24.sp)
                        : null,
                  ),
                  title: Text(
                    chat['name']!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 16.sp,
                      color:
                          isDark ? AppColors.neutral50 : AppColors.neutral900,
                    ),
                  ),
                  subtitle: Text(
                    chat['message']!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutral400,
                      fontSize: 14.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        chat['time']!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.neutral400,
                          fontSize: 12.sp,
                        ),
                      ),
                      if (chat['unread'] > 0) ...[
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary500,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            chat['unread'].toString(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoomScreen(
                        userId: 'user_${index + 1}',
                        userName: chat['name']!,
                        userAvatar: chat['avatar'],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
