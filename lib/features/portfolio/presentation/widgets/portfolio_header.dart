import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';

class PortfolioHeader extends StatelessWidget {
  const PortfolioHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SliverAppBar(
      floating: true,
      title: Text(
        'Portfolio',
        style: theme.textTheme.headlineMedium?.copyWith(
          color: isDark ? AppColors.neutral50 : AppColors.neutral900,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            EneftyIcons.filter_outline,
            color: isDark ? AppColors.neutral50 : AppColors.neutral900,
          ),
          onPressed: () {
            // TODO: Implement filter action
          },
        ),
      ],
    );
  }
}
