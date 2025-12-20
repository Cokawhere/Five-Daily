import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lens/constents/colors.dart';
import 'package:lens/constents/layout.dart';
import 'package:lens/features/onboarding/presentation/cubit/auth_cubit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          if (state.isNewUser || state.appUser.completedProfile == false) {
            context.go('/interests');
          } else {
            context.go('/home');
          }
        } else if (state is Error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          print('login errore:${state.message}');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgLightGrey,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.screenHeight * 0.02,
              horizontal: context.screenWidth * 0.03,
            ),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final isLoading = state is Loading;
                return Column(
                  children: [
                    SizedBox(height: context.screenHeight * 0.02),
                    Wrap(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'GET THE LATEST HEADLINES ',
                            style: TextStyle(
                              color: AppColors.mint,
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w900,
                            ),
                            children: [
                              TextSpan(
                                text: 'Anytime-Anywhere',
                                style: TextStyle(color: AppColors.purple),
                              ),
                              TextSpan(
                                text:
                                    ' EXPLORE PERSONALIZED NEWS THAT KEEPS YOU AHEAD.',
                                style: TextStyle(color: AppColors.textDark),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.screenHeight * 0.09),
                    Hero(
                      tag: 'welcome_image',
                      child: SizedBox(
                        width: context.screenWidth * 1,
                        height: context.screenHeight * .4,
                        child: Image.asset(
                          'assets/images/M.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: context.screenHeight * 0.15),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      height: context.screenHeight * 0.07,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isLoading
                            ? AppColors.bgLightGrey
                            : AppColors.mint,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.textDark, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.textDark,
                            offset: Offset(4, 4),
                            blurRadius: 0,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: isLoading
                              ? null
                              : () => context.read<AuthCubit>().googleSignIn(),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    fontFamily: 'Google Sans',
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF3C4043),
                                    letterSpacing: 0.15,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Image.asset(
                                  'assets/images/google.png',
                                  height: 25.h,
                                  width: 25.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.screenHeight * 0.01),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
