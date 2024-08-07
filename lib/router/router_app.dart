import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/screens/home_screen.dart';
import 'package:pos/presentation/screens/onboarding_screen.dart';
import 'package:pos/presentation/screens/settings_screen.dart';
import 'package:pos/presentation/screens/sign_in_screen.dart';
import 'package:pos/presentation/screens/sign_up_screen.dart';
import 'package:pos/router/named_route.dart';

final router = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: NamedRoute.routeOnBoarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
      redirect: (BuildContext context, GoRouterState state) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          return NamedRoute.routeHome;
        }
        return null;
      },
    ),
    GoRoute(
      path: NamedRoute.routeHome,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: NamedRoute.routeSettings,
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: NamedRoute.routeSignIn,
      name: 'signIn',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: NamedRoute.routeSignUp,
      name: 'signUp',
      builder: (context, state) => const SignUpScreen(),
    ),
  ],
);
