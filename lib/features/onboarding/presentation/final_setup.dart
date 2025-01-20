import 'package:flutter/material.dart';
import 'package:juniper/features/onboarding/widgets/section_title.dart';
import '../../../core/utils/utils.dart';
import '../widgets/picture_selector.dart';

class FinalTouchesStep extends StatelessWidget {
  final String? profilePictureUrl;
  final String? additionalPreferences;
  final String moveInTimeline;
  final Function(String?) onProfilePictureChanged;
  final Function(String?) onAdditionalPreferencesChanged;
  final Function(String) onMoveInTimelineChanged;

  const FinalTouchesStep({
    super.key,
    this.profilePictureUrl,
    this.additionalPreferences,
    required this.moveInTimeline,
    required this.onProfilePictureChanged,
    required this.onAdditionalPreferencesChanged,
    required this.onMoveInTimelineChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Profile Picture (Optional)'),
        SizedBox(height: 6.sp),
        ProfilePictureSelector(
          // Optional
          onImageSelected: (String path) {
            // Handle the selected image path
          },
          size: 120, // Optional: customize size
        ),
        SizedBox(height: 24.sp),
        SectionTitle(title: 'Move-In Timeline'),
        SizedBox(height: 6.sp),
        _buildMoveInTimelineSelector(context),
        SizedBox(height: 24.sp),
        SectionTitle(
          title: 'Additional Preferences (Optional)',
        ),
        SizedBox(height: 6.sp),
        _buildAdditionalPreferencesInput(context),
        SizedBox(height: 32.sp),
      ],
    );
  }

  Widget _buildMoveInTimelineSelector(BuildContext context) {
    final timelineOptions = [
      "Immediately",
      "Within 1 month",
      "In 3+ months",
    ];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark100 : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? AppColors.surfaceDark300 : AppColors.borderLight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: moveInTimeline,
          isExpanded: true,
          hint: Text(
            'Select move-in timeline',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.neutral500,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp),
          ),
          items: timelineOptions.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          isDark ? AppColors.neutral300 : AppColors.neutral400,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0,
                    ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onMoveInTimelineChanged(newValue);
            }
          },
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.neutral500,
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalPreferencesInput(BuildContext context) {
    return TextFormField(
      initialValue: additionalPreferences,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: "Tell us if there's anything specific you're looking for",
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.neutral500,
              fontWeight: FontWeight.w500,
            ),
        filled: true,
        focusColor: AppColors.neutral500,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
        ),
        contentPadding: EdgeInsets.all(16.sp),
      ),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.neutral500,
          ),
      onChanged: onAdditionalPreferencesChanged,
    );
  }
}
