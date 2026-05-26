import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grab_it/firebase_options.dart';
import 'package:grab_it/injection_container.dart' as di;
import 'core/theme/app_theme.dart';

void main() async {
  // Ensuring Flutter bindings are ready before using Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // initialise firebase with generated options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Getit init
  await di.init();

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
