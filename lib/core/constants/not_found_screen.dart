import 'package:flutter/material.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/button.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.gray300),
            padding: MaterialStateProperty.all(EdgeInsets.all(8)),
          ),
          icon: Icon(EneftyIcons.arrow_left_3_outline),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/404-error.png',
              width: 250.sp,
              height: 250.sp,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 32.sp),
            Text(
              'Page Not Found',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontFamily: 'HelveticaNeue',
                    color: AppColors.neutral500,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.5.sp,
                    letterSpacing: -0.5,
                  ),
            ),
            SizedBox(height: 12.sp),
            Text(
              "Oops! The page you are looking for doesn't exist or has been moved.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'HelveticaNeue',
                    color: AppColors.gray500,
                    fontWeight: FontWeight.normal,
                    height: 1.3,
                    fontSize: 14.sp,
                    letterSpacing: -0.1,
                  ),
            ),
            const Spacer(),
            CustomButton(
              height: 48.sp,
              width: double.infinity,
              onPressed: () {
                // Navigate to home or main screen
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login', // or your home route
                  (route) => false,
                );
              },
              text: 'Go Back Home',
              size: ButtonSize.medium,
            ),
            SizedBox(height: 24.sp),
          ],
        ),
      ),
    );
  }
}