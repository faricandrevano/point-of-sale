import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';
import 'package:pos/presentation/widgets/custom_filled_button.dart';
import 'package:pos/router/named_route.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  int activePage = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int page) {
            setState(() {
              activePage = page;
            });
          },
          controller: pageController,
          children: [
            OnboardingView(
              pageController: pageController,
              activePage: 0,
              heading: 'Easy products and\n sales management',
              body:
                  'Effortlessly manage all your store transactions\n and products in one app',
              img: 'assets/images/img_onboarding_1.png',
            ),
            OnboardingView(
              pageController: pageController,
              activePage: 1,
              heading: 'Choose your own\n payment method',
              body:
                  'Seamless payout with various payment method\n you can choose from',
              img: 'assets/images/img_onboarding_2.png',
            ),
            OnboardingView(
              pageController: pageController,
              activePage: 2,
              heading: 'Manage branch\n without worries',
              body:
                  'Track all your store branches and operation with\n confidence',
              img: 'assets/images/img_onboarding_3.png',
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({
    super.key,
    required this.pageController,
    required this.activePage,
    required this.body,
    required this.heading,
    required this.img,
  });

  final PageController pageController;
  final int activePage;
  final String img, heading, body;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => context.go(NamedRoute.routeSignUp),
                child: Text(
                  'Skip',
                  style: bodyL.copyWith(
                    fontWeight: semiBold,
                    color: primaryMain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 350,
              child: Image.asset(img),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                3,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () {
                        pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        width: activePage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: activePage == index ? neutral100 : neutral10,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: neutral50,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            Text(
              heading,
              style: headingM.copyWith(
                fontWeight: bold,
                color: neutral90,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              body,
              textAlign: TextAlign.center,
              style: bodyL.copyWith(
                fontWeight: regular,
                color: neutral60,
              ),
            ),
            const SizedBox(height: 56),
            CustomFilledButton(
              label: 'Continue',
              icon: Icon(Icons.arrow_forward, color: neutral10),
              onPressed: () {
                if (activePage > 1) {
                  context.go(NamedRoute.routeSignUp);
                }
                pageController.animateToPage(activePage + 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
            )
          ],
        ),
      ),
    );
  }
}
