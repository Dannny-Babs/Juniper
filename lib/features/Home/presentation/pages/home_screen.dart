import 'package:flutter/material.dart';
import 'package:juniper/core/utils/colors.dart';
import 'package:juniper/core/utils/packages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header Section
            SliverToBoxAdapter(
              child: HomeHeader(),
            ),

            // Main Content Section
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: MainContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutral300.withAlpha(130),
                      fontWeight: FontWeight.normal,
                      fontSize: 14.sp,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        EneftyIcons.location_outline,
                        size: 16.sp,
                        // ignore: deprecated_member_use
                        color: AppColors.primary500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Brooklyn, NY',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.neutral500,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(EneftyIcons.notification_outline),
                onPressed: () {},
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Text(
            'Hi, George!',
            style: theme.textTheme.titleLarge?.copyWith(
                color: const Color(0xFF697385),
                fontWeight: FontWeight.normal,
                fontSize: 18.sp),
          ),
          const SizedBox(height: 8),
          Text(
            'Ready to find your next\ninvestment?',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.neutral300,
              fontSize: 28.sp,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),

        // Search Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.onSurface.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              const SizedBox(width: 12),
              Text(
                'Search investments',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Quick Actions Section
        Text(
          'Quick Actions',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildQuickActionCard(
                context,
                icon: Icons.trending_up,
                title: 'Trending',
              ),
              _buildQuickActionCard(
                context,
                icon: Icons.star_outline,
                title: 'Popular',
              ),
              _buildQuickActionCard(
                context,
                icon: Icons.bolt_outlined,
                title: 'New',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
