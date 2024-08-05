import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pos/firebase_options.dart';
import 'package:pos/presentation/screens/home_screen.dart';
import 'package:pos/presentation/screens/sign_in_screen.dart';
import 'package:pos/presentation/screens/sign_up_screen.dart';

void main(List<String> args) async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/sign-up',
      routes: {
        '/': (_) => const HomeScreen(),
        '/sign-up': (_) => const SignUpScreen(),
        '/sign-in': (_) => const SignInScreen(),
      },
    );
  }
}
