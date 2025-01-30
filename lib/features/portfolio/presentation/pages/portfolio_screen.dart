import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';
import '../widgets/metric_card.dart';
import '../widgets/portfolio_chart.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  int selectedTimeframe = 1; // 1M selected by default
  int selectedCardIndex = 0;
  final List<String> timeframes = ['1D', '1M', '3M', '1Y', '3Y', '5Y'];

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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isDark ? AppColors.backgroundDark : AppColors.surfaceLight,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color:
                      isDark ? AppColors.surfaceDark100 : AppColors.borderLight,
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
          const SizedBox(height: 24),
          _buildChart(),
          const SizedBox(height: 24),
          _buildMetricCards(),
        ],
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
            fontSize: 40.sp,
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
        const SizedBox(
          height: 250,
          child: PortfolioChart(),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              timeframes.length,
              (index) => _buildTimeframeButton(index),
            ),
          ),
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
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: summaryCards.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.6,
                margin: const EdgeInsets.only(right: 16),
                child: MetricCard(
                  title: summaryCards[index]['title']!,
                  value: summaryCards[index]['value']!,
                  description: summaryCards[index]['description']!,
                  isSelected: selectedCardIndex == index,
                  onTap: () => setState(() => selectedCardIndex = index),
                ),
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
              margin: const EdgeInsets.symmetric(horizontal: 1.0),
              width: selectedCardIndex == index ? 15.0 : 5.0,
              height: 5.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: selectedCardIndex == index
                    ? AppColors.primary500
                    : AppColors.neutral400,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
