import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class BudgetRangeSlider extends StatefulWidget {
  const BudgetRangeSlider({super.key});

  @override
  State<BudgetRangeSlider> createState() => _BudgetRangeSliderState();
}

class _BudgetRangeSliderState extends State<BudgetRangeSlider> {
  static const double _min = 0;
  static const double _max = 10000;
  RangeValues _currentRange = const RangeValues(1000, 5000);

  void _updateRange(bool isStart, String value) {
    final double? parsedValue = double.tryParse(value);
    if (parsedValue == null) return;
    
    setState(() {
      _currentRange = isStart
          ? RangeValues(parsedValue.clamp(_min, _currentRange.end), _currentRange.end)
          : RangeValues(_currentRange.start, parsedValue.clamp(_currentRange.start, _max));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RangeSlider(
          values: _currentRange,
          min: _min,
          max: _max,
          divisions: 20,
          activeColor: AppColors.primary500,
          inactiveColor: Colors.grey[300],
          labels: RangeLabels(
            '\$${_currentRange.start.toInt()}',
            '\$${_currentRange.end.toInt()}',
          ),
          onChanged: (RangeValues newRange) => setState(() => _currentRange = newRange),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _BudgetInput(
              label: 'Min Budget',
              value: _currentRange.start.toInt(),
              onChanged: (value) => _updateRange(true, value),
            ),
            _BudgetInput(
              label: 'Max Budget',
              value: _currentRange.end.toInt(),
              onChanged: (value) => _updateRange(false, value),
            ),
          ],
        ),
      ],
    );
  }
}

class _BudgetInput extends StatelessWidget {
  const _BudgetInput({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
                color: AppColors.neutral300,
              ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 100,
          child: TextFormField(
            initialValue: value.toString(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
