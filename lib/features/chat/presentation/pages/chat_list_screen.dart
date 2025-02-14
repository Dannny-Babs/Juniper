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
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(EneftyIcons.message_edit_outline),
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  expandedHeight: 120.h,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Chat',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: isDark
                                            ? AppColors.textPrimaryDark
                                            : AppColors.neutral800,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w500),
                              ),
                              Stack(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        EneftyIcons.notification_outline),
                                    onPressed: () {},
                                  ),
                                  Positioned(
                                    right: 12,
                                    top: 12,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search messages',
                              prefixIcon:
                                  Icon(EneftyIcons.search_normal_outline),
                              filled: true,
                              fillColor: isDark
                                  ? AppColors.surfaceDark100
                                  : AppColors.neutral50,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.w),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        children: [
                          _buildTab('All', true, context),
                          _buildTab('Unread', false, context),
                          _buildTab('Archived', false, context),
                          _buildTab('Spam', false, context),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: AppConstants.padding12,
                        top: AppConstants.padding4),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: isDark
                          ? AppColors.surfaceDark100
                          : AppColors.neutral200,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final chat = chats[index];
                      return ListTile(
                        style: ListTileStyle.list,
                        leading: CircleAvatar(
                          radius: 20.r,
                          backgroundImage: chat['avatar'] != null
                              ? NetworkImage(chat['avatar'] as String)
                              : null,
                          child: chat['avatar'] == null
                              ? Icon(EneftyIcons.user_outline, size: 24.sp)
                              : null,
                        ),
                        title: Text(
                          chat['name']!,
                          style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: 16.sp,
                              color: isDark
                                  ? AppColors.neutral50
                                  : AppColors.neutral700,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.09.sp),
                        ),
                        subtitle: Text(
                          chat['message']!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDark
                                ? AppColors.neutral600
                                : AppColors.neutral400,
                            fontSize: 13.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: SizedBox(
                          width: 60.w, // Fixed width for trailing widget
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Add this
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
                                    horizontal: 6.w,
                                    vertical: 1.h,
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 18.w, // Add minimum width
                                    minHeight: 18.h, // Add minimum height
                                  ),
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
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        onTap: () => context.pushNamed(
                          'chatRoom',
                          pathParameters: {'userId': 'user_${index + 1}'},
                          extra: chat['name'] as String,
                        ),
                      );
                    },
                    childCount: chats.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTab(
    String text,
    bool isSelected,
    BuildContext context,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: FilterChip(
        backgroundColor: isSelected ? AppColors.primary500 : Colors.transparent,
        selectedColor: AppColors.primary500,
        shape: StadiumBorder(
          side: BorderSide(
            color: isSelected
                ? AppColors.primary500
                : isDark
                    ? AppColors.surfaceDark200
                    : AppColors.neutral200,
          ),
        ),
        label: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? Colors.white
                    : isDark
                        ? AppColors.neutral50
                        : AppColors.neutral700,
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
        ),
        selected: isSelected,
        onSelected: (bool selected) {
          // Handle tab selection
        },
      ),
    );
  }
}
