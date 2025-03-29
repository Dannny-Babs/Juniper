import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class SegmentedTabWidget extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> content;
  final bool showPropertyType;
  final EdgeInsetsGeometry padding;

  const SegmentedTabWidget({
    super.key,
    required this.tabs,
    required this.content,
    this.showPropertyType = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
  });

  @override
  State<SegmentedTabWidget> createState() => _SegmentedTabWidgetState();
}

class _SegmentedTabWidgetState extends State<SegmentedTabWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this)
      ..addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      setState(() => _currentIndex = _tabController.index);
    }
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_handleTabChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTabBar(theme, isDark),
            ),
            if (widget.showPropertyType) ...[
              SizedBox(width: 4.w),
              _buildPropertyTypeChip(theme, isDark),
            ],
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 310, // Adjust this height as needed
          child: IndexedStack(
            index: _currentIndex,
            children: widget.content,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(ThemeData theme, bool isDark) {
    return Container(
      height: 40,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        padding: EdgeInsets.zero,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: isDark ? AppColors.primary500 : AppColors.primary600,
        unselectedLabelColor:
            isDark ? AppColors.neutral500 : AppColors.neutral700,
        labelStyle: theme.textTheme.titleMedium?.copyWith(
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: theme.textTheme.titleMedium?.copyWith(
          fontSize: 13.sp,
          fontWeight: FontWeight.normal,
        ),
        tabs: widget.tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }

  Widget _buildPropertyTypeChip(ThemeData theme, bool isDark) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? AppColors.surfaceDark200 : AppColors.neutral200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            EneftyIcons.buildings_2_outline,
            color: isDark ? AppColors.neutral500 : AppColors.neutral700,
            size: 20,
          ),
          const SizedBox(width: 6),
          Text(
            'Apartment',
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
