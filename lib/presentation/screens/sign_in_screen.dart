import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pos/presentation/widgets/custom_textfield_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool? checked;
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign in POS account',
                  style: headingS.copyWith(fontWeight: bold, color: neutral90),
                ),
                const SizedBox(height: 8),
                Text(
                  'Welcome! Please login your account.',
                  style: bodyL.copyWith(fontWeight: regular, color: neutral60),
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    CustomTextfieldAuth(
                      label: 'Phone number or Email',
                      hintText: 'ex. yourname@gmail.com',
                      prefixIcon: 'assets/icons/icons_textfield_email.png',
                      controller: controllerEmail,
                    ),
                    const SizedBox(height: 16),
                    CustomTextfieldAuth(
                      label: 'Password',
                      hintText: 'Type your password here',
                      obsecureText: true,
                      prefixIcon: 'assets/icons/icons_textfield_password.png',
                      controller: controllerPassword,
                    ),
                    const SizedBox(height: 21),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                side: BorderSide(
                                  width: 1,
                                  color: neutral60,
                                ),
                                value: checked ?? false,
                                onChanged: (valueCurrent) {
                                  setState(() {
                                    checked = valueCurrent;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Remember me',
                              style: bodyM.copyWith(
                                fontWeight: medium,
                                color: neutral90,
                              ),
                            )
                          ],
                        ),
                        Text(
                          'Forget Password?',
                          style: bodyS.copyWith(
                            fontWeight: semiBold,
                            color: primaryMain,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 32),
                    CustomFilledButton(
                      label: 'Login',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 29),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: neutral30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'or',
                            style: bodyM.copyWith(
                              color: neutral60,
                              fontWeight: regular,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: neutral30,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: neutral10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: primaryMain,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/icons_google.png',
                              scale: 2,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Sign up with Google',
                              style: bodyL.copyWith(
                                fontWeight: semiBold,
                                color: primaryMain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: bodyL.copyWith(
                        fontWeight: medium,
                        color: neutral90,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => context.goNamed('/sign-up'),
                      child: Text(
                        'Sign up',
                        style: bodyL.copyWith(
                          fontWeight: medium,
                          color: primaryMain,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}