import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lens/features/onboarding/presentation/cubit/auth_cubit.dart';
import 'package:lens/features/onboarding/presentation/screens/screen_1.dart';
import 'package:lens/features/splashscreen/splashscreen.dart';
import '../features/interests/presentation/screens/interest.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/welcome',

  redirect: (context, state) async {
    final authState = context.read<AuthCubit>().state;
    final location = state.uri.toString();

    if (location == '/splashscreen') {
      if (authState is Loading) return null;
      if (authState is Initial) return '/welcome';
      if (authState is Authenticated) {
        return authState.appUser.completedProfile ? '/home' : '/interests';
      }
    }

    if (authState is Authenticated && authState.appUser.completedProfile) {
      return '/home';
    } else if (authState is Authenticated &&
        !authState.appUser.completedProfile) {
      return '/interests';
    }

    if (authState is Loading) {
      return '/splashscreen';
    }

    if (authState is Loading) {
      return '/splashscreen';
    }

    if (authState is Initial) {
      return '/welcome';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: "/welcome",
      name: 'onboarding',
      builder: (context, state) => WelcomeScreen(),
    ),
    GoRoute(
      path: '/interests',
      name: 'interests-page',
      builder: (context, state) => InterestsScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'page-page',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/splashscreen',
      name: 'splashscreen',
      builder: (context, state) => SplashScreen(),
    ),
  ],
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Home Screen')));
  }
}
