import 'package:flutter/material.dart';
import 'package:juniper/features/authentication/presentation/widgets/signup_button.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/button.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.sp),
            Text(
              'Login',
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
              'Access your curated properties and investment insights with ease',
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
            SizedBox(height: 48.sp),
            LoginForm(formKey: formKey),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Do something
                },
                child: Text(
                  'Forgot password?',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary500,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.1,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            CustomButton(
              height: 48.sp,
              text: 'Login',
              backgroundColor: AppColors.neutral500,
              textColor: AppColors.neutral100,
              size: ButtonSize.medium,
              isLoading: false, // You may want to bind this to a state variable
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // Do something
                }
              },
            ),
            SizedBox(height: 24.sp),
            _buildDivider(context),
            SizedBox(height: 24.sp),
            SignUpButtons(),
            SizedBox(height: 16.sp),
            // Add a tex row or inkwell to navigate to the sign up page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New to Juniper? ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color.fromARGB(163, 80, 80, 101),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                InkWell(
                  onTap: () {
                    // Add navigation logic here
                    // Navigator.pushNamed(context, '/signup');
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.sp, horizontal: 2.sp),
                    child: Text(
                      "Let's get you started",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.neutral500,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.gray300,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: Text(
            'or',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.gray500,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.1,
                ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.gray300,
          ),
        ),
      ],
    );
  }
}
