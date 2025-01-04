import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const LoginForm({required this.formKey, super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.neutral500,
                  )),
          const SizedBox(height: AppConstants.padding4),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your email',
              hintStyle:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.gray500,
                      ),
              filled: true,
              fillColor: Colors.white,
              focusColor: AppColors.neutral500,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            validator: emailValidator.call,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppConstants.padding16),
          Text('Password',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.neutral500,
                  )),
          const SizedBox(height: AppConstants.padding4),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your password',
              hintStyle:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.gray500,
                      ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Color(0xFFEAECF0),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColors.neutral500,
                  width: 1.5,
                ),
              ),
              suffixIcon: Icon(
                Icons.visibility,
                color: AppColors.gray700.withAlpha(200),
              ),
            ),
            obscureText: true,
            validator: passwordValidator.call,
          ),
        ],
      ),
    );
  }
}
