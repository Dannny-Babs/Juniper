import 'package:flutter/material.dart';
import 'package:juniper/core/utils/colors.dart';
import 'package:juniper/core/utils/packages.dart';
import '../widgets/segmented_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      top: false,
      child: CustomScrollView(
        slivers: [
          // Header Section
          SliverToBoxAdapter(
            child: HomeHeader(),
          ),

          // Main Content Section
          SliverPadding(
            sliver: SliverToBoxAdapter(
              child: MainContent(),
            ),
            padding: const EdgeInsets.only(top: 2),
          ),
        ],
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.surfaceLight,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: isDark ? AppColors.neutral800 : AppColors.borderLight,
          ),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Location section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Location',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutral400,
                      fontWeight: FontWeight.normal,
                      fontSize: 15.sp,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        EneftyIcons.location_outline,
                        size: 18.sp,
                        color: AppColors.primary500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Toronto, ON',
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: isDark ? Colors.white : AppColors.neutral800,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.5.sp,
                            letterSpacing: 0),
                      ),
                    ],
                  ),
                ],
              ),

              // Notification button
              Center(
                child: IconButton(
                  padding: EdgeInsets.all(8),
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(
                          color: isDark
                              ? AppColors.neutral800
                              : AppColors.borderLight,
                        ),
                      ),
                    ),
                  ),
                  icon: const Icon(EneftyIcons.notification_outline, size: 22),
                  onPressed: () {},
                  color: isDark ? AppColors.neutral300 : AppColors.neutral800,
                ),
              ),
            ],
          ),
          SizedBox(height: 32.sp),
          Text(
            'Hi, George!',
            style: theme.textTheme.titleLarge?.copyWith(
                color: isDark ? AppColors.neutral200 : AppColors.neutral500,
                fontWeight: FontWeight.normal,
                fontSize: 18.5.sp),
          ),
          const SizedBox(height: 8),
          Text(
            'Ready to find your next\ninvestment?',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textPrimaryDark : AppColors.neutral900,
              fontSize: 26.sp,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 16),

          // Filter row
          Row(
            children: [
              Expanded(
                // Search Bar

                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        EneftyIcons.search_normal_outline,
                        color: isDark
                            ? AppColors.neutral300
                            : AppColors.neutral700,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        // Add this
                        child: Text(
                          'Search apartments, condos, etc.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0,
                            color: isDark
                                ? AppColors.neutral400
                                : AppColors.neutral600,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Add this to handle text overflow
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                child: Icon(
                  EneftyIcons.setting_4_outline,
                  color: theme.colorScheme.onSurface.withAlpha(179),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height * 0.7), // Add bounded height
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            width: 1,
            color: isDark ? AppColors.neutral800 : AppColors.borderLight,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Actions Section
          Text(
            'Popular Properties',
            style: theme.textTheme.displayMedium?.copyWith(
              color: isDark ? AppColors.neutral200 : AppColors.neutral800,
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
            ),
          ),
          const SizedBox(height: 16),

          // Property Card
          _buildPropertyCard(
            imageUrl:
                'https://odimaconstruction.ca/wp-content/uploads/2022/07/custom-homes-1024x683.jpg',
            title: 'The Grand Apartments',
            location: 'Toronto, ON',
            price: '\$1,200,000',
            roi: '12%',
          ),
          const SizedBox(height: 16),

          // Quick Action Row
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
      ),
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

  Widget _buildPropertyCard({
    required String imageUrl,
    required String title,
    required String location,
    required String price,
    required String roi,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isDark ? AppColors.neutral800 : AppColors.borderLight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(6.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with error handling
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: SizedBox(
                height: 180.sp,
                width: double.infinity,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: theme.colorScheme.surface,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: theme.colorScheme.onSurface.withOpacity(0.4),
                          size: 40,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: theme.colorScheme.surface,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Content section
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      fontSize: 18.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        EneftyIcons.location_outline,
                        size: 16,
                        color: isDark
                            ? AppColors.neutral300
                            : AppColors.neutral500,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0,
                            color: isDark
                                ? AppColors.neutral300
                                : AppColors.neutral500,
                            fontSize: 14.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          price,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 17.sp,
                            color: AppColors.primary600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ROI: ',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: isDark
                                  ? AppColors.neutral300
                                  : AppColors.neutral500,
                            ),
                          ),
                          Text(
                            roi,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.neutral100
                                  : AppColors.neutral900,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
