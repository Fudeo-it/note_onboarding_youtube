import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:note_onboarding/models/onboarding.dart';

class OnboardingContent extends StatelessWidget {
  final Onboarding onboarding;
  final ValueNotifier<double> notifier;
  final int page;

  const OnboardingContent(
    this.onboarding, {
    super.key,
    required this.notifier,
    this.page = 0,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width;

    return SlidingPage(
      page: page,
      notifier: notifier,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(onboarding.image, width: size, height: size),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                onboarding.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              onboarding.message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
