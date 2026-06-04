import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:grab_it/core/theme/app_colors.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_event.dart';
import 'package:grab_it/features/auth/presentation/bloc/auth_state.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  
  String uid = '';
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthUserNewState) {
      uid = authState.uid;
      phoneNumber = authState.mobileNumber;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailureState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthUserExistsState) {
            // Profile saved successfully!
            final target = state.user.role == 'owner' ? '/merchant-dashboard' : '/home';
            context.go(target);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(234, 243, 222, 1),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      color: AppColors.primaryLight,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  Text(
                    'Set up your profile',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Let's get to know you better. Please provide your basic details.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textTertiary,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  
                  // NAME FIELD
                  Text(
                    'FULL NAME',
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
                      color: const Color.fromRGBO(242, 242, 242, 1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFFD3D1C7),
                        width: 0.5,
                      ),
                    ),
                    child: TextField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: 'John Doe',
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xFFAFAFA5),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ADDRESS FIELD
                  Text(
                    'DELIVERY ADDRESS',
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
                      color: const Color.fromRGBO(242, 242, 242, 1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFFD3D1C7),
                        width: 0.5,
                      ),
                    ),
                    child: TextField(
                      controller: _addressController,
                      keyboardType: TextInputType.streetAddress,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: '123 Main Street',
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xFFAFAFA5),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 48.h),
                  
                  // SAVE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              if (_nameController.text.trim().isEmpty || 
                                  _addressController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please fill all fields')),
                                );
                                return;
                              }
                              
                              context.read<AuthBloc>().add(
                                AuthSaveProfileEvent(
                                  uid: uid,
                                  phoneNumber: phoneNumber,
                                  name: _nameController.text.trim(),
                                  address: _addressController.text.trim(),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(30, 144, 255, 198),
                        disabledBackgroundColor: const Color.fromARGB(255, 194, 197, 202),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        elevation: 0,
                      ),
                      child: state is AuthLoading
                          ? SizedBox(
                              height: 24.h,
                              width: 24.h,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Save Profile',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
