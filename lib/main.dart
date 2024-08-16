import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pos/blocs/auth_bloc/auth_bloc.dart';
import 'package:pos/blocs/cart_bloc/cart_bloc.dart';
import 'package:pos/blocs/cashier_bloc/cashier_bloc.dart';
import 'package:pos/blocs/product_bloc/product_bloc.dart';
import 'package:pos/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:pos/firebase_options.dart';
import 'package:pos/router/router_app.dart';
import 'package:pos/utils/flutter_notification.dart';

void main(List<String> args) async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HelperNotification().initLocalNotification();
  runApp(const MyApp());
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<ProductBloc>(create: (context) => ProductBloc()),
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<CashierBloc>(create: (context) => CashierBloc()),
        BlocProvider<TransactionBloc>(create: (context) => TransactionBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
