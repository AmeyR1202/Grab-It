import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:grab_it/core/theme/app_colors.dart';

class EnterNumberPage extends StatefulWidget {
  const EnterNumberPage({super.key});

  @override
  State<EnterNumberPage> createState() => _EnterNumberPageState();
}

class _EnterNumberPageState extends State<EnterNumberPage> {
  final TextEditingController _phoneController = TextEditingController();

  String get fullPhoneNumber => '+91${_phoneController.text}';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(234, 243, 222, 1),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  Icons.phone_android_rounded,
                  color: AppColors.primaryLight,
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 28.h),
              Text(
                'Enter your mobile number',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "We'll send a one-time verification code to confirm your number.",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textTertiary,
                  height: 1.6,
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'MOBILE NUMBER',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: const Color(0xFF888780),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                height: 52.h,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFFD3D1C7),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        '+91',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF2C2C2A),
                        ),
                      ),
                    ),
                    Container(
                      width: 0.5,
                      height: 28.h,
                      color: const Color(0xFFD3D1C7),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        autofocus: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: TextStyle(fontSize: 16.sp, letterSpacing: 0.5),
                        decoration: InputDecoration(
                          hintText: '81313782626',
                          hintStyle: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 16.sp,
                          ),
                          border: InputBorder.none,
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                        ),
                        cursorColor: const Color(0xFF3B6D11),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  // onPressed: _phoneController.text.length == 10
                  //     ? () => context.read<AuthBloc>().add(
                  //         AuthSendOtpEvent(phoneNumber: fullPhoneNumber),
                  //       )
                  //     : null,
                  onPressed: () => context.go('/enter-otp'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
