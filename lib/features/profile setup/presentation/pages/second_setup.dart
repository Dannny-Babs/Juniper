import 'package:flutter/material.dart';
import 'package:juniper/features/profile%20setup/presentation/widgets/budget_slider.dart';
import '../../../../core/utils/utils.dart';
import '../widgets/section_title.dart';

class PreferencesStep extends StatefulWidget {
  final List<String> selectedHousingTypes;
  final double? budget;
  final List<String> selectedLocations;
  final Function(List<String>) onHousingTypesChanged;
  final Function(double?) onBudgetChanged;
  final Function(List<String>) onLocationsChanged;

  const PreferencesStep({
    super.key,
    required this.selectedHousingTypes,
    this.budget,
    required this.selectedLocations,
    required this.onHousingTypesChanged,
    required this.onBudgetChanged,
    required this.onLocationsChanged,
  });

  @override
  State<PreferencesStep> createState() => _PreferencesStepState();
}

class _PreferencesStepState extends State<PreferencesStep> {
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final List<String> _housingTypes = [
    'Apartment',
    'House',
    'Townhouse',
    'Studio',
    'Condo',
    'Duplex',
    'Room',
    'Loft',
    'Villa',
    'Real Estate',
    'Terrace',
    'Penthouse',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.budget != null) {
      _budgetController.text = widget.budget!.toStringAsFixed(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Housing Preferences'),
        SizedBox(height: 6.sp),
        _buildHousingTypeSelector(),
        SizedBox(height: 24.sp),
        SectionTitle(title: 'Monthly Budget'),
        SizedBox(height: 6.sp),
        BudgetRangeSlider(
          initialRange: RangeValues(1000, 5000),
          minValue: 0,
          maxValue: 10000,
          divisions: 20,
          onRangeChanged: (RangeValues range) {
            // Handle range changes
            print('New range: ${range.start} - ${range.end}');
          },
        ),
        SizedBox(height: 24.sp),
        SectionTitle(title: 'Preferred Locations'),
        SizedBox(height: 6.sp),
        _buildLocationSelector(context),
        SizedBox(height: 10.sp),
        _buildSelectedLocations(),
        SizedBox(height: 32.sp),
      ],
    );
  }

  Widget _buildHousingTypeSelector() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Wrap(
      spacing: 8.sp,
      runSpacing: 8.sp,
      children: _housingTypes.map((type) {
        final isSelected = widget.selectedHousingTypes.contains(type);
        return InkWell(
          onTap: () {
            final updatedSelection =
                List<String>.from(widget.selectedHousingTypes);
            if (isSelected) {
              updatedSelection.remove(type);
            } else {
              updatedSelection.add(type);
            }
            widget.onHousingTypesChanged(updatedSelection);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.sp,
              vertical: 4.sp,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary700 : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary700
                    : isDark
                        ? AppColors.surfaceDark300
                        : AppColors.borderLight,
              ),
            ),
            child: Text(
              type,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isSelected ? Colors.white : AppColors.neutral500,
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLocationSelector(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _locationController,
          decoration: InputDecoration(
            hintText: 'Enter cities or zip codes',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.neutral500,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
            filled: true,
            focusColor: AppColors.neutral500,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.add, color: AppColors.primary500),
              onPressed: () {
                if (_locationController.text.isNotEmpty) {
                  widget.onLocationsChanged([
                    ...widget.selectedLocations,
                    _locationController.text,
                  ]);
                  _locationController.clear();
                }
              },
            ),
          ),
          onFieldSubmitted: (value) {
            if (value.isNotEmpty) {
              widget.onLocationsChanged([
                ...widget.selectedLocations,
                value,
              ]);
              _locationController.clear();
            }
          },
        ),
      ],
    );
  }

  Widget _buildSelectedLocations() {
    return Wrap(
      spacing: 8.sp,
      runSpacing: 8.sp,
      children: widget.selectedLocations.map((location) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.sp,
            vertical: 6.sp,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary500.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                location,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary500,
                      fontSize: 13.sp,
                    ),
              ),
              SizedBox(width: 4.sp),
              InkWell(
                onTap: () {
                  widget.onLocationsChanged(
                    widget.selectedLocations
                        .where((l) => l != location)
                        .toList(),
                  );
                },
                child: Icon(
                  Icons.close,
                  size: 16.sp,
                  color: AppColors.primary500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _budgetController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
