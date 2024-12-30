import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';

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
        _buildSectionTitle(context, 'Profile Picture (Optional)'),
        SizedBox(height: 6.sp),
        _buildProfilePictureSelector(context),
        SizedBox(height: 24.sp),
        
        _buildSectionTitle(context, 'Move-In Timeline'),
        SizedBox(height: 6.sp),
        _buildMoveInTimelineSelector(context),
        SizedBox(height: 24.sp),
        
        _buildSectionTitle(context, 'Additional Preferences (Optional)'),
        SizedBox(height: 6.sp),
        _buildAdditionalPreferencesInput(context),
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

  Widget _buildProfilePictureSelector(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Implement image picker logic here
              onProfilePictureChanged("path/to/selected/image.png");
            },
            child: Container(
              width: 120.sp,
              height: 120.sp,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: profilePictureUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(60.sp),
                      child: Image.network(
                        profilePictureUrl!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.camera_alt_outlined,
                      size: 32.sp,
                      color: AppColors.neutral500,
                    ),
            ),
          ),
          SizedBox(height: 12.sp),
          if (profilePictureUrl != null)
            TextButton(
              onPressed: () => onProfilePictureChanged(null),
              child: Text(
                'Remove',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.red[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMoveInTimelineSelector(BuildContext context) {
    final timelineOptions = [
      "Immediately",
      "Within 1 month",
      "In 3+ months",
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: timelineOptions.map((option) {
          return Column(
            children: [
              RadioListTile<String>(
                value: option,
                groupValue: moveInTimeline,
                onChanged: (value) => onMoveInTimelineChanged(value!),
                title: Text(
                  option,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
                activeColor: AppColors.primary500,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.sp),
              ),
              if (option != timelineOptions.last)
                Divider(height: 1, color: Colors.grey[300]),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAdditionalPreferencesInput(BuildContext context) {
    return TextFormField(
      initialValue: additionalPreferences,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: "Tell us if there's anything specific you're looking for",
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.gray500,
        ),
        filled: true,
        fillColor: Colors.white,
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