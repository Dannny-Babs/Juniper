// lib/features/home/presentation/widgets/search_bar_widget.dart
import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  EneftyIcons.search_normal_outline,
                  color: isDark ? AppColors.neutral300 : AppColors.neutral700,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Search apartments, condos, etc.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                      color: isDark ? AppColors.neutral400 : AppColors.neutral600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        FilterButton(isDark: isDark),
      ],
    );
  }
}

// lib/features/home/presentation/widgets/filter_button.dart
class FilterButton extends StatelessWidget {
  final bool isDark;

  const FilterButton({required this.isDark, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Icon(
        EneftyIcons.setting_4_outline,
        color: theme.colorScheme.onSurface.withAlpha(179),
      ),
    );
  }
}