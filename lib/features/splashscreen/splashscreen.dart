import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lens/constents/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      context.go('/welcome');  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLightGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'splash_logo',  
              child: AnimatedContainer(
                duration: const Duration(seconds: 2), 
                curve: Curves.easeInOut,
                width: 200.w,
                height: 200.h,
                child: Image.asset('assets/images/app_icon.jpg', fit: BoxFit.contain),
              ),
            ),
            Spacer(),
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              curve: Curves.easeIn,
              child: Text(
                '© 2025 Lens',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}