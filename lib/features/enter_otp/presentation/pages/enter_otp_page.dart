import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class EnterOtpPage extends StatefulWidget {
  const EnterOtpPage({super.key});

  @override
  State<EnterOtpPage> createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {
  final TextEditingController _otpController = TextEditingController();

  int remainingSeconds = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();

    remainingSeconds = 30;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  String formatTime(int seconds) {
    return "00:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 52.w,
      height: 60.h,
      textStyle: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade500),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Text(
                'Verify OTP',
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 12.h),

              Text(
                'We sent a code to',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade700),
              ),

              SizedBox(height: 10.h),

              Text(
                '+91 9876543210',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 40.h),

              Center(
                child: Pinput(
                  controller: _otpController,
                  length: 6,
                  autofocus: true,
                  defaultPinTheme: defaultPinTheme,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                // onPressed: _otpController.text.length == 6
                //     ? () => context.read<AuthBloc>().add(
                //         AuthSendOtpEvent(phoneNumber: fullPhoneNumber),
                //       )
                //     : null,
                onPressed: () => context.go(''),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(30, 144, 255, 198),
                  disabledBackgroundColor: const Color.fromARGB(
                    255,
                    194,
                    197,
                    202,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Send OTP',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.arrow_forward_rounded, size: 18.sp),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
