import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
