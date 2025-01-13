import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/button.dart';
import '../../../navigation/presentation/bloc/navigation_bloc.dart';

class EmailVerificationPage extends StatefulWidget {
  final String email;

  const EmailVerificationPage({
    super.key,
    required this.email,
  });

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final int otpLength = 6;
  Timer? _timer;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  int _remainingTime = 30;
  bool _canResendCode = false;

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
    if (!mounted) return;

    setState(() {
      _remainingTime = 30;
      _canResendCode = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

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
    _timer?.cancel();
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                    color:
                        isDarkMode ? AppColors.neutral50 : AppColors.neutral900,
                    fontWeight: FontWeight.w500,
                    fontSize: 26.sp,
                    letterSpacing: -0.5,
                  ),
            ),
            SizedBox(height: 6.sp),
            Text(
              'Please enter the verification code sent to\n${widget.email}',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'HelveticaNeue',
                    fontWeight: FontWeight.normal,
                    height: 1.3,
                    fontSize: 16.sp,
                    letterSpacing: -0.1,
                    color: isDarkMode
                        ? AppColors.neutral200
                        : AppColors.neutral800,
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
                      hintText: '0',
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      errorStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.error500),
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
                        fontSize: 14.sp,
                      ),
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              height: 48.sp,
              width: double.infinity,
              isDisabled: !_isOtpComplete(),
              backgroundColor: _isOtpComplete()
                  ? (isDarkMode
                      ? AppColors.backgroundLight
                      : AppColors.neutral800)
                  : isDarkMode
                      ? AppColors.neutral800.withAlpha(50)
                      : AppColors.neutral200,
              textColor: _isOtpComplete()
                  ? (isDarkMode
                      ? AppColors.neutral900
                      : AppColors.backgroundLight)
                  : (isDarkMode ? AppColors.neutral600 : AppColors.neutral500),
              onPressed: !_isOtpComplete()
                  ? null
                  : () {
                      // Implement verification logic here
                      context
                          .read<NavigationBloc>()
                          .add(AuthenticationStatusChanged(true));
                       

                      // Navigate to home
                      context.go('/home');
                    },
              text: 'Verify',
              size: ButtonSize.medium,
            ),
            SizedBox(height: 24.sp),
          ],
        ),
      ),
    );
  }
}
