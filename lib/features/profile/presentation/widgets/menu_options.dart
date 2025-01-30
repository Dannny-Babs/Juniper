// Menu Item Model
import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

// Menu Options Widget
class MenuOptions extends StatelessWidget {
  final List<MenuItem> menuItems;

  const MenuOptions({
    super.key,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            width: 1,
            color: isDark ? AppColors.surfaceDark100 : AppColors.borderLight,
          ),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: menuItems.asMap().entries.map((entry) {
          final isLast = entry.key == menuItems.length - 1;
          return Column(
            children: [
              _buildMenuItem(entry.value, context),
              if (!isLast)
                Divider(
                  color:
                      isDark ? AppColors.surfaceDark100 : AppColors.borderLight,
                  thickness: 1,
                  height: 1,
                ),
              if (!isLast) const SizedBox(height: 8),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem(MenuItem item, BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      minVerticalPadding: 16,
      leading: Icon(item.icon,
          color: isDarkMode ? AppColors.neutral300 : AppColors.neutral600,
          size: 22),
      title: Text(
        item.title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isDarkMode ? AppColors.neutral100 : AppColors.neutral800,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
      ),
      trailing: Icon(Icons.chevron_right,
          color: isDarkMode ? AppColors.neutral700 : AppColors.neutral400),
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      onTap: item.onTap,
    );
  }
}
