import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: PlatformBackButton(
          onPressed: () => Navigator.of(context).pop(),
          color: AppColors.neutral500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.sp),
            Text(
              'Forgot Password',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontFamily: 'HelveticaNeue',
                    color: AppColors.neutral500,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.5.sp,
                    letterSpacing: -0.5,
                  ),
            ),
            SizedBox(height: 6.sp),
            Text(
              'Forgot your password? Don’t worry, it happens to the best of us!',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'HelveticaNeue',
                    color: AppColors.gray500,
                    fontWeight: FontWeight.normal,
                    height: 1.3,
                    fontSize: 14.sp,
                    letterSpacing: -0.1,
                  ),
            ),
            SizedBox(height: 32.sp),
            Form(
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
                    controller: emailController,
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
                  SizedBox(height: 24.sp),
                  CustomButton(
                    height: 48.sp,
                    width: double.infinity,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Do something
                      }
                    },
                    text: 'Reset Password',
                    size: ButtonSize.medium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
