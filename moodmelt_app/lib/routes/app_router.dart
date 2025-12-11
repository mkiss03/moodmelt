import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/microtherapy/presentation/stress_balloon_screen.dart';
import '../features/microtherapy/presentation/thought_tornado_screen.dart';
import '../features/microtherapy/presentation/mind_declutter_screen.dart';
import '../features/microtherapy/presentation/box_breathing_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String stressBalloon = '/stress-balloon';
  static const String thoughtTornado = '/thought-tornado';
  static const String mindDeclutter = '/mind-declutter';
  static const String boxBreathing = '/box-breathing';

  static final GoRouter router = GoRouter(
    initialLocation: onboarding,
    routes: [
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: home,
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: stressBalloon,
        name: 'stress-balloon',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const StressBalloonScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: thoughtTornado,
        name: 'thought-tornado',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ThoughtTornadoScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: mindDeclutter,
        name: 'mind-declutter',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const MindDeclutterScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: boxBreathing,
        name: 'box-breathing',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const BoxBreathingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
    ],
  );
}
