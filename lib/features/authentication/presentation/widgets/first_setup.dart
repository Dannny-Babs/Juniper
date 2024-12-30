import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';

class PersonalInfoStep extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final DateTime? dateOfBirth;
  final Function(DateTime) onDateSelected;

  const PersonalInfoStep({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    this.dateOfBirth,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          context,
          'First Name',
          'Enter your first name',
          firstNameController,
        ),
        SizedBox(height: 16.sp),
        _buildInputField(
          context,
          'Last Name',
          'Enter your last name',
          lastNameController,
        ),
        SizedBox(height: 16.sp),
        Text(
          'Date of Birth',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.neutral300,
              ),
        ),
        SizedBox(height: 8.sp),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: dateOfBirth ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              onDateSelected(date);
            }
          },
          child: Container(
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateOfBirth != null
                      ? DateFormat('MM/dd/yyyy').format(dateOfBirth!)
                      : 'MM/DD/YYYY',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: dateOfBirth != null
                            ? AppColors.neutral500
                            : AppColors.gray500,
                      ),
                ),
                Icon(EneftyIcons.calendar_2_outline, color: AppColors.gray500),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.sp),
        Text(
          'Who are you?',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.neutral300, letterSpacing: 0),
        ),
        SizedBox(height: 6.sp),
        Row(
          children: [
            _buildGenderButton(context),
            SizedBox(width: 16.sp),
            _buildGenderButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderButton(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Text(
            'Student', // You might want to make this dynamic
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context,
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.neutral300,
              ),
        ),
        SizedBox(height: 6.sp),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.gray500,
                ),
            filled: true,
            fillColor: Colors.white,
            focusColor: AppColors.neutral500,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
          ),
        ),
      ],
    );
  }
}

// Similar widgets for other steps...
