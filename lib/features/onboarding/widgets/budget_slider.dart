import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/utils.dart';

class BudgetRangeSlider extends StatefulWidget {
  const BudgetRangeSlider({
    super.key,
    this.initialRange,
    this.minValue = 0,
    this.maxValue = 10000,
    this.divisions = 20,
    this.onRangeChanged,
  });

  final RangeValues? initialRange;
  final double minValue;
  final double maxValue;
  final int divisions;
  final void Function(RangeValues)? onRangeChanged;

  @override
  State<BudgetRangeSlider> createState() => _BudgetRangeSliderState();
}

class _BudgetRangeSliderState extends State<BudgetRangeSlider> {
  late RangeValues _currentRange;
  final _startController = TextEditingController();
  final _endController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentRange = widget.initialRange ?? 
        RangeValues(widget.minValue + (widget.maxValue - widget.minValue) * 0.1,
                   widget.minValue + (widget.maxValue - widget.minValue) * 0.5);
    _updateTextControllers();
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  void _updateTextControllers() {
    _startController.text = formatCurrency(_currentRange.start);
    _endController.text = formatCurrency(_currentRange.end);
  }

  String formatCurrency(double value) {
    return '\$${value.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},'
        )}';
  }

  void _updateRange(bool isStart, String value) {
    final cleanValue = value.replaceAll(RegExp(r'[^\d]'), '');
    final double? parsedValue = double.tryParse(cleanValue);
    if (parsedValue == null) return;

    setState(() {
      if (isStart) {
        _currentRange = RangeValues(
          parsedValue.clamp(widget.minValue, _currentRange.end),
          _currentRange.end
        );
      } else {
        _currentRange = RangeValues(
          _currentRange.start,
          parsedValue.clamp(_currentRange.start, widget.maxValue)
        );
      }
      _updateTextControllers();
    });
    widget.onRangeChanged?.call(_currentRange);
  }

  void _handleSliderChange(RangeValues newRange) {
    setState(() {
      _currentRange = newRange;
      _updateTextControllers();
    });
    widget.onRangeChanged?.call(_currentRange);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RangeSlider(
          values: _currentRange,
          min: widget.minValue,
          max: widget.maxValue,
          divisions: widget.divisions,
          activeColor: AppColors.primary500,
          inactiveColor: Colors.grey[300],
          labels: RangeLabels(
            formatCurrency(_currentRange.start),
            formatCurrency(_currentRange.end),
          ),
          onChanged: _handleSliderChange,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _BudgetInput(
              label: 'Min Budget',
              controller: _startController,
              onChanged: (value) => _updateRange(true, value),
            ),
            _BudgetInput(
              label: 'Max Budget',
              controller: _endController,
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
    required this.controller,
    required this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.neutral300,
                letterSpacing: 0,
              ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 120,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d,.$]')),
            ],
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}