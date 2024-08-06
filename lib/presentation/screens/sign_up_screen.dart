import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pos/presentation/widgets/custom_textfield_auth.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPhone = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    TextEditingController controllerConfirmPassword = TextEditingController();
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
                  'Sign up POS account',
                  style: headingS.copyWith(fontWeight: bold, color: neutral90),
                ),
                const SizedBox(height: 8),
                Text(
                  'Welcome! Please register your account.',
                  style: bodyL.copyWith(fontWeight: regular, color: neutral60),
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    CustomTextfieldAuth(
                      label: 'Email',
                      hintText: 'ex. yourname@gmail.com',
                      prefixIcon: 'assets/icons/icons_textfield_email.png',
                      controller: controllerEmail,
                    ),
                    const SizedBox(height: 16),
                    CustomTextfieldAuth(
                      label: 'Phone Number',
                      hintText: 'ex. 9889-9870-9865',
                      controller: controllerPhone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    CustomTextfieldAuth(
                      label: 'Password',
                      hintText: 'Type your password here',
                      obsecureText: true,
                      prefixIcon: 'assets/icons/icons_textfield_password.png',
                      controller: controllerPassword,
                    ),
                    const SizedBox(height: 16),
                    CustomTextfieldAuth(
                      label: 'Confirm Password',
                      hintText: 'Confirm your password',
                      obsecureText: true,
                      prefixIcon: 'assets/icons/icons_textfield_password.png',
                      controller: controllerConfirmPassword,
                    ),
                    const SizedBox(height: 32),
                    CustomFilledButton(
                      label: 'Register',
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 29),
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
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: bodyL.copyWith(
                        fontWeight: medium,
                        color: neutral90,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => context.goNamed('/sign-in'),
                      child: Text(
                        'Sign in',
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
