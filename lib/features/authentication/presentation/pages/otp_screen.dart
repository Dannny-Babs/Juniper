import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/button.dart';

class EmailVerificationPage extends StatefulWidget {
  final String email;

  const EmailVerificationPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final int otpLength = 6;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  bool _canResendCode = false;
  int _remainingTime = 30;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      otpLength,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      otpLength,
      (index) => FocusNode(),
    );
    _startResendTimer();
  }

  void _startResendTimer() {
    setState(() {
      _remainingTime = 30;
      _canResendCode = false;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        setState(() {
          _canResendCode = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpDigitChanged(int index, String value) {
    if (value.length == 1 && index < otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  bool _isOtpComplete() {
    return _controllers.every((controller) => controller.text.length == 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
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
              'Verify Email',
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
              'Please enter the verification code sent to\n${widget.email}',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    
                    decoration: InputDecoration(                      
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '0',
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.gray500,
                      ),
                      errorStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.error500
                      ),


                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                    onChanged: (value) => _onOtpDigitChanged(index, value),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: _canResendCode
                    ? () {
                        // Implement resend logic here
                        _startResendTimer();
                      }
                    : null,
                child: Text(
                  _canResendCode
                      ? "Didn't receive the code?"
                      : 'Resend code in $_remainingTime seconds',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.gray500,
                        fontSize: 14.sp,
                      ),
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              height: 48.sp,
              width: double.infinity,
              onPressed: _isOtpComplete()
                  ? () async {
                      String otp = _controllers.map((c) => c.text).join();
                      print('OTP: $otp');

                      

                      // Navigate to the next screen
                      context.push('/profile-setup');
                    }
                    : null,
              text: 'Verify',
              size: ButtonSize.medium,
              isDisabled: !_isOtpComplete(),
            ),
            SizedBox(height: 24.sp),
          ],
        ),
      ),
    );
  }
}
