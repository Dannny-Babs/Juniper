import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/features/profile/presentation/widgets/menu_options.dart';
import 'package:juniper/features/profile/presentation/widgets/profile_header.dart';

// Main Profile Screen
class ProfileScreen extends StatelessWidget {
  final Function(int)? onNavigate;

  const ProfileScreen({
    super.key,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    ProfileHeader(),
                    Expanded(
                      child: MenuOptions(
                        menuItems: [
                          MenuItem(
                            title: 'Refer a friend',
                            icon: EneftyIcons.gift_outline,
                            onTap: () => onNavigate?.call(0),
                          ),
                          MenuItem(
                            title: 'Notification',
                            icon: EneftyIcons.notification_outline,
                            onTap: () => onNavigate?.call(1),
                          ),
                          MenuItem(
                            title: 'Settings',
                            icon: EneftyIcons.setting_2_outline,
                            onTap: () => onNavigate?.call(2),
                          ),
                          MenuItem(
                            title: 'Help center',
                            icon: Icons.help_outline,
                            onTap: () => onNavigate?.call(3),
                          ),
                          MenuItem(
                            title: 'Security & privacy',
                            icon: EneftyIcons.security_outline,
                            onTap: () => onNavigate?.call(4),
                          ),
                          MenuItem(
                            title: 'Log out',
                            icon: EneftyIcons.logout_outline,
                            onTap: () => onNavigate?.call(5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
