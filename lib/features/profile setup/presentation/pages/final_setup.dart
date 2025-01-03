import 'package:flutter/material.dart';
import 'package:juniper/features/profile%20setup/presentation/widgets/section_title.dart';
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
        SectionTitle(title: 'Profile Picture (Optional)'),
        SizedBox(height: 6.sp),
        _buildProfilePictureSelector(context),
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

  Widget _buildProfilePictureSelector(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                onProfilePictureChanged(image.path);
              }
            },
            child: Container(
              width: 100.sp,
              height: 100.sp,
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
                      EneftyIcons.camera_bold,
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
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.gray300),
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
                ),
          ),
          items: timelineOptions.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutral500,
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
