import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/data/models/product_model.dart';
import 'package:pos/presentation/screens/cart_screen.dart';
import 'package:pos/presentation/screens/cashier_screen.dart';
import 'package:pos/presentation/screens/detail_cashier_screen.dart';
import 'package:pos/presentation/screens/home_screen.dart';
import 'package:pos/presentation/screens/onboarding_screen.dart';
import 'package:pos/presentation/screens/payment_method_screen.dart';
import 'package:pos/presentation/screens/product_data_screen.dart';
import 'package:pos/presentation/screens/product_detail_screen.dart';
import 'package:pos/presentation/screens/product_screen.dart';
import 'package:pos/presentation/screens/settings_screen.dart';
import 'package:pos/presentation/screens/sign_in_screen.dart';
import 'package:pos/presentation/screens/sign_up_screen.dart';
import 'package:pos/presentation/screens/success_transaction_screen.dart';
import 'package:pos/presentation/screens/transaction_screen.dart';
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
      path: NamedRoute.routeProduct,
      name: 'product',
      builder: (context, state) => const ProductScreen(),
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
    GoRoute(
      path: NamedRoute.routeCashier,
      name: 'cashier',
      builder: (context, state) => const CashierScreen(),
    ),
    GoRoute(
      path: NamedRoute.routeDetailProductCashier,
      name: 'cashier detail',
      builder: (context, state) {
        ProductModel product = state.extra as ProductModel;
        return DetailCashierScreen(
          product: product,
        );
      },
    ),
    GoRoute(
      path: NamedRoute.routeProductDataScreen,
      name: 'product data',
      builder: (context, state) => const ProductDataScreen(),
    ),
    GoRoute(
      path: NamedRoute.routeProductUpdateScreen,
      name: 'product update data',
      builder: (context, state) {
        ProductModel product = state.extra as ProductModel;
        return ProductDataScreen(
          product: product,
        );
      },
    ),
    GoRoute(
      path: NamedRoute.routeDetailProductScreen,
      name: 'product detail data',
      builder: (context, state) {
        ProductModel args = state.extra as ProductModel;
        return ProductDetailScreen(
          data: args,
        );
      },
    ),
    GoRoute(
      path: NamedRoute.routeCartScreen,
      name: 'Carts data',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: NamedRoute.routePaymentScreen,
      name: 'Payment',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return PaymentMethodScreen(
          customerName: data['customerName'],
          tax: data['tax'],
          total: data['total'],
        );
      },
    ),
    GoRoute(
      path: NamedRoute.routeSuccessPayment,
      name: 'success payement',
      builder: (context, state) => const SuccessTransactionScreen(),
    ),
    GoRoute(
      path: NamedRoute.routeTransaction,
      name: 'Transaction list',
      builder: (context, state) => const TransactionScreen(),
    ),
  ],
);
