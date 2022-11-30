import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_constants.dart';
import '../../constants/ui/text_style.dart';
import '../../widgets/buttons/gradient_button.dart';
import '../login/cubit/login_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _controller,
          children: onboardingContent
              .map(
                (page) => OnboardingView(
                  imageUrl: page['imageUrl']!,
                  title: page['title']!,
                  subTitle: page['subTitle']!,
                  onButtonPressed: () async => await context
                      .read<LoginCubit>()
                      .onOnboardingNextButtonPressed(_controller),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.onButtonPressed,
  });

  final String imageUrl;
  final String title;
  final String subTitle;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
              Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                subTitle,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
                  height: 2.0,
                ),
              ),
              SizedBox(
                height: 57.0,
                width: 157.0,
                child: GradientButton(
                  onPressed: onButtonPressed,
                  child: const Text(
                    'Next',
                    style: FTextStyles.button,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
