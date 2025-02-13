import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartTooltip extends StatelessWidget {
  final String value;

  const ChartTooltip({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        value,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class PortfolioChart extends StatelessWidget {
  const PortfolioChart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                fitInsideHorizontally: true,
                fitInsideVertically: true,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    return LineTooltipItem(
                      '\$${(spot.y * 1000).toStringAsFixed(0)}',
                      TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.2,
                      ),
                    );
                  }).toList();
                },
                //tooltipBgColor: theme.colorScheme.primary.withOpacity(0.8),
                tooltipRoundedRadius: 8,
                tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              getTouchedSpotIndicator: (barData, spotIndexes) {
                return spotIndexes.map((spotIndex) {
                  return TouchedSpotIndicatorData(
                    FlLine(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                      strokeWidth: 2,
                      dashArray: [4, 4],
                    ),
                    FlDotData(
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 6,
                          color: Colors.white,
                          strokeWidth: 3,
                          strokeColor: theme.colorScheme.primary,
                        );
                      },
                      show: true,
                    ),
                  );
                }).toList();
              },
              handleBuiltInTouches: true,
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              getDrawingHorizontalLine: (value) => FlLine(
                color: isDark 
                    ? Colors.white.withAlpha(13)
                    : Colors.black.withAlpha(13),
                strokeWidth: 1,
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 46,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        '\$${(value * 1000).toInt()}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark 
                              ? Colors.white.withOpacity(0.5)
                              : Colors.black.withOpacity(0.5),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final timeframes = ['1D', '1W', '1M', '3M', '1Y', 'All'];
                    if (value.toInt() >= 0 && value.toInt() < timeframes.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          timeframes[value.toInt()],
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDark 
                                ? Colors.white.withOpacity(0.5)
                                : Colors.black.withOpacity(0.5),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                    return const Text('');
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(0, 1.5),
                  const FlSpot(1, 2.0),
                  const FlSpot(2, 2.2),
                  const FlSpot(3, 2.8),
                  const FlSpot(4, 3.4),
                  const FlSpot(5, 3.2),
                ],
                isCurved: true,
                curveSmoothness: 0.35,
                preventCurveOverShooting: true,
                color: theme.colorScheme.primary,
                barWidth: 2.5,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.25),
                      theme.colorScheme.primary.withOpacity(0.0),
                    ],
                    stops: const [0.0, 0.95],
                  ),
                ),
              ),
            ],
            minX: 0,
            maxX: 5,
            minY: 0,
            maxY: 4,
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      ),
    );
  }
}
