// Property Metrics Card Widget
import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';

class PropertyMetricsCard extends StatelessWidget {
  final TextStyle? valueTextStyle;
  final TextStyle? supportingTextStyle;

  const PropertyMetricsCard({
    super.key,
    this.valueTextStyle,
    this.supportingTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final defaultValueStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.textPrimaryDark
              : AppColors.neutral800,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        );

    final defaultSupportingStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(
          color: isDarkMode ? AppColors.textPrimaryDark : AppColors.neutral800,
          fontSize: 13.sp,
        );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: _buildMetricColumn(
                  label: 'My property',
                  value: '6',
                  supporting: 'property',
                  percentage: '↑ 6,82%',
                  isPositive: true,
                  context: context,
                  valueStyle: valueTextStyle ?? defaultValueStyle,
                  supportingStyle:
                      supportingTextStyle ?? defaultSupportingStyle,
                ),
              ),
              VerticalDivider(
                color: Theme.of(context).dividerColor,
                width: 32,
                thickness: 1,
              ),
              Expanded(
                child: _buildMetricColumn(
                  label: 'Income',
                  value: '\$240',
                  supporting: 'monthly',
                  percentage: '↓ 2,02%',
                  isPositive: false,
                  context: context,
                  valueStyle: valueTextStyle ?? defaultValueStyle,
                  supportingStyle:
                      supportingTextStyle ?? defaultSupportingStyle,
                ),
              ),
              VerticalDivider(
                color: Theme.of(context).dividerColor,
                width: 32,
                thickness: 1,
              ),
              Expanded(
                child: _buildMetricColumn(
                  label: 'Balance',
                  value: '\$',
                  supporting: '245.900',
                  percentage: '↑ 6,82%',
                  isPositive: true,
                  context: context,
                  valueStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDarkMode
                            ? AppColors.neutral600
                            : AppColors.neutral400,
                        fontWeight: FontWeight.w500,
                      ),
                  supportingStyle:
                      Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: isDarkMode
                                ? AppColors.neutral100
                                : AppColors.neutral800,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricColumn({
    required String label,
    required String value,
    required String supporting,
    required String percentage,
    required bool isPositive,
    required BuildContext context,
    required TextStyle? valueStyle,
    required TextStyle? supportingStyle,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(
              label == 'My property'
                  ? EneftyIcons.buildings_2_outline
                  : label == 'Income'
                      ? EneftyIcons.money_recive_outline
                      : EneftyIcons.coin_outline,
              size: 16,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDarkMode
                        ? AppColors.neutral600
                        : AppColors.neutral500,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (supporting.isNotEmpty)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: valueStyle,
                ),
                TextSpan(
                  text: ' $supporting',
                  style: supportingStyle,
                ),
              ],
            ),
          )
        else
          Text(
            value,
            style: valueStyle,
          ),
        const SizedBox(height: 2),
        Text(
          percentage,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isPositive ? AppColors.success500 : AppColors.error500,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
        ),
      ],
    );
  }
}
