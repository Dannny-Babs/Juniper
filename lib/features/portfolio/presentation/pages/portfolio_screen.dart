import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/features/portfolio/presentation/widgets/portfolio_chart.dart';
import '../../../home/data/repositories/property.dart';
import '../../domain/models/portfolio_property.dart';
import '../widgets/metric_card.dart';
import '../widgets/property_card.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  int selectedTimeframe = 1; // 1M selected by default
  int selectedCardIndex = 0;
  final List<String> timeframes = ['1D', '1M', '3M', '1Y', '3Y', '5Y'];
  late final PageController _pageController = PageController(
    initialPage: selectedCardIndex,
  );
  List<PortfolioProperty> properties = [];
  bool isLoading = true;

  final List<Map<String, String>> summaryCards = [
    {
      'title': 'Asset Value',
      'value': '\$1,243,535',
      'description': 'Combined value of all investments',
    },
    {
      'title': 'Rental Rewards',
      'value': '\$12,435',
      'description': 'Monthly income from rentals',
    },
    {
      'title': 'Profit/Loss',
      'value': '+\$8,200',
      'description': 'Net gain or loss this month',
    },
    {
      'title': 'Annual ROI',
      'value': '8.2%',
      'description': 'Average return on investments',
    },
    {
      'title': 'Properties',
      'value': '5',
      'description': 'Total properties in portfolio',
    },
  ];

  Future<void> _loadProperties() async {
    if (mounted) {
      setState(() => isLoading = true);
    }

    try {
      final loadedProperties = await PropertyProvider.loadProperties(limit: 100); // Use a specific integer value or remove the parameter if it has a default
      if (mounted) {
        setState(() {
          properties = loadedProperties
              .where(
                  (p) => p.imageUrl.isNotEmpty) // Filter out invalid properties
              .map((p) => PortfolioProperty.fromProperty(p))
              .toList();
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading properties: $e');
      if (mounted) {
        setState(() {
          properties = [];
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color:
                    isDark ? AppColors.backgroundDark : AppColors.surfaceLight,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: isDark
                        ? AppColors.surfaceDark100
                        : AppColors.borderLight,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildBalanceCard(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppConstants.padding20,
                horizontal: AppConstants.padding8,
              ),
              decoration: BoxDecoration(
                color:
                    isDark ? AppColors.backgroundDark : AppColors.surfaceLight,
                border: Border.all(
                  color:
                      isDark ? AppColors.surfaceDark100 : AppColors.neutral200,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildChart(),
                  const SizedBox(height: 24),
                  _buildMetricCards(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Add Assets Section
            Container(
              decoration: BoxDecoration(
                color:
                    isDark ? AppColors.backgroundDark : AppColors.surfaceLight,
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: isDark
                        ? AppColors.surfaceDark100
                        : AppColors.borderLight,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Assets',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.neutral800,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 16),
                    _buildAssetsList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Portfolio',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: isDark ? AppColors.textPrimaryDark : AppColors.neutral800,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500),
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
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
    );
  }

  Widget _buildBalanceCard() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Balance',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.neutral500,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '\$1,243,535',
          style: theme.textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 32.sp,
            color: isDark ? AppColors.textPrimaryDark : AppColors.neutral800,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              '+ 6.82%',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.success500,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            Text(
              ' Last month',
              style: theme.textTheme.bodyMedium?.copyWith(
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.neutral500,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChart() {
    return Column(
      children: [
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              timeframes.length,
              (index) => _buildTimeframeButton(index),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: PortfolioChart(),
        ),
      ],
    );
  }

  Widget _buildTimeframeButton(int index) {
    final isSelected = selectedTimeframe == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTimeframe = index),
      child: Column(
        children: [
          Text(
            timeframes[index],
            style: TextStyle(
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              width: 16,
              height: 2,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMetricCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          SizedBox(
            height: 105,
            child: PageView.builder(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              padEnds: false,
              itemCount: summaryCards.length,
              onPageChanged: (index) {
                setState(() => selectedCardIndex = index);
              },
              itemBuilder: (context, index) {
                return MetricCard(
                  title: summaryCards[index]['title']!,
                  value: summaryCards[index]['value']!,
                  description: summaryCards[index]['description']!,
                  onTap: () {},
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              summaryCards.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                width: selectedCardIndex == index ? 16.w : 6.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: selectedCardIndex == index
                      ? Theme.of(context).primaryColor
                      : AppColors.neutral300,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetsList() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (properties.isEmpty) {
      return Center(
        child: Text(
          'No properties found',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: properties.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final property = properties[index];
        return PropertyCard(
          property: property, // Remove index parameter
          onTap: () {
            Navigator.of(context).pushNamed('/property', arguments: property);
          },
        );
      },
    );
  }
}
