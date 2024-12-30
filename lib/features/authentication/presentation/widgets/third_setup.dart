import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';

class LifestyleStep extends StatefulWidget {
  final List<String> selectedAmenities;
  final List<String> selectedCommunityFeatures;
  final String? furnishingPreference;
  final String? otherRequirements;
  final Function(List<String>) onAmenitiesChanged;
  final Function(List<String>) onCommunityFeaturesChanged;
  final Function(String?) onFurnishingChanged;
  final Function(String?) onRequirementsChanged;

  const LifestyleStep({
    super.key,
    required this.selectedAmenities,
    required this.selectedCommunityFeatures,
    this.furnishingPreference,
    this.otherRequirements,
    required this.onAmenitiesChanged,
    required this.onCommunityFeaturesChanged,
    required this.onFurnishingChanged,
    required this.onRequirementsChanged,
  });

  @override
  State<LifestyleStep> createState() => _LifestyleStepState();
}

class _LifestyleStepState extends State<LifestyleStep> {
  final TextEditingController _requirementsController = TextEditingController();

  final List<String> _amenities = [
    'Pet-Friendly',
    'Gym Access',
    'Swimming Pool',
    'Parking',
    'Outdoor Space (Garden/Balcony)',
    'Nearby Public Transport',
  ];

  final List<String> _communityFeatures = [
    'Close to Schools',
    'Shopping & Dining Nearby',
    'Quiet Neighborhood',
    'Walkability',
  ];

  final List<String> _furnishingOptions = [
    'Furnished',
    'Unfurnished',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.otherRequirements != null) {
      _requirementsController.text = widget.otherRequirements!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Amenities Preferences'),
        SizedBox(height: 6.sp),
        _buildMultiSelector(
          items: _amenities,
          selectedItems: widget.selectedAmenities,
          onChanged: widget.onAmenitiesChanged,
        ),
        SizedBox(height: 24.sp),
        _buildSectionTitle(context, 'Preferred Community Features'),
        SizedBox(height: 6.sp),
        _buildMultiSelector(
          items: _communityFeatures,
          selectedItems: widget.selectedCommunityFeatures,
          onChanged: widget.onCommunityFeaturesChanged,
        ),
        SizedBox(height: 24.sp),
        _buildSectionTitle(context, 'Furnishing Preference'),
        SizedBox(height: 6.sp),
        _buildFurnishingSelector(),
        SizedBox(height: 32.sp),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.neutral300,
            fontWeight: FontWeight.w500,
          ),
    );
  }

  Widget _buildMultiSelector({
    required List<String> items,
    required List<String> selectedItems,
    required Function(List<String>) onChanged,
  }) {
    return Wrap(
      spacing: 8.sp,
      runSpacing: 8.sp,
      children: items.map((item) {
        final isSelected = selectedItems.contains(item);
        return InkWell(
          onTap: () {
            final updatedSelection = List<String>.from(selectedItems);
            if (isSelected) {
              updatedSelection.remove(item);
            } else {
              updatedSelection.add(item);
            }
            onChanged(updatedSelection);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.sp,
              vertical: 4.sp,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary500 : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.primary700 : Colors.grey.shade300,
              ),
            ),
            child: Text(
              item,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isSelected ? Colors.white : AppColors.neutral500,
                    fontSize: 12.5.sp,
                  ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFurnishingSelector() {
    return Row(
      children: _furnishingOptions.map((option) {
        final isSelected = widget.furnishingPreference == option;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: option == _furnishingOptions.first ? 8.sp : 0,
              left: option == _furnishingOptions.last ? 8.sp : 0,
            ),
            child: InkWell(
              onTap: () => widget.onFurnishingChanged(option),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.sp),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary500 : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary700
                        : Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: Text(
                    option,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              isSelected ? Colors.white : AppColors.neutral500,
                        ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _requirementsController.dispose();
    super.dispose();
  }
}
