import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Grab It',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const HomePage(),
        );
      },
    );
  }
}

// 2. Create the new Widget down here
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'GrabIt Foundation Set!',
          style: TextStyle(fontSize: 24.sp),
        ),
      ),
    );
  }
}
