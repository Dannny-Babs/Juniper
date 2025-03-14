import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';

class PropertyDescription extends StatefulWidget {
  final String description;
  final int maxLines;

  const PropertyDescription({
    Key? key,
    required this.description,
    this.maxLines = 3,
  }) : super(key: key);

  @override
  State<PropertyDescription> createState() => _PropertyDescriptionState();
}

class _PropertyDescriptionState extends State<PropertyDescription> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.neutral100 : AppColors.neutral700,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          widget.description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? AppColors.neutral300 : AppColors.neutral700,
            height: 1.5,
          ),
          maxLines: _expanded ? null : widget.maxLines,
          overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (widget.description.length > 100) ...[
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Text(
              _expanded ? 'Show less' : 'Read more',
              style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.primary500,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.1),
            ),
          ),
        ],
        SizedBox(height: 16.h),
      ],
    );
  }
}
