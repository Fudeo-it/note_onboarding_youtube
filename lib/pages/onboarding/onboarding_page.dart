import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:note_onboarding/misc/resources.dart';
import 'package:note_onboarding/models/onboarding.dart';
import 'package:note_onboarding/pages/onboarding/widgets/onboarding_content.dart';
import 'package:note_onboarding/pages/sign_in/sign_in_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const _contents = [
    Onboarding(
      title: 'Organizza le tue idee',
      message:
          'Scrivi, salva e organizza le tue note in un attimo. Tieni tutto sotto controllo senza perdere nessuna idea',
      image: R.imageOnboarding1,
    ),
    Onboarding(
      title: 'Sincronizza ovunque',
      message:
          'Accedi alle tue note da qualsiasi dispositivo, senza preoccuparti di perdere nulla. La sincronizzazione è automatica e sicura',
      image: R.imageOnboarding2,
    ),
    Onboarding(
      title: 'Trova tutto in un istante',
      message:
          'Usa la ricerca intelligente per trovare velocemente le tue note, anche tra centinaia di appunti',
      image: R.imageOnboarding3,
    ),
    Onboarding(
      title: 'Personalizza come vuoi',
      message:
          'Aggiungi colori, tag e categorie per rendere le tue note più organizzate e intuitive',
      image: R.imageOnboarding4,
    ),
  ];

  final ValueNotifier<double> _notifier = ValueNotifier(0);
  final _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    _pageController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            children: _contents
                .asMap()
                .entries
                .map(
                  (entry) => OnboardingContent(
                    entry.value,
                    notifier: _notifier,
                    page: entry.key,
                  ),
                )
                .toList(growable: false),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ValueListenableBuilder(
                    valueListenable: _notifier,
                    builder: (context, page, _) {
                      if (page.toInt() == _contents.length - 1) {
                        return const SizedBox.shrink();
                      }

                      return TextButton(
                        onPressed: () => _navigateToSignIn(context),
                        child: Text('Salta'),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SlidingIndicator(
                    notifier: _notifier,
                    activeIndicatorSize: 16.0,
                    inactiveIndicatorSize: 16.0,
                    margin: 4.0,
                    activeIndicator: Icon(
                      Icons.circle,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    inActiveIndicator: Icon(
                      Icons.circle_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    indicatorCount: _contents.length,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ValueListenableBuilder(
                    valueListenable: _notifier,
                    builder: (context, page, _) {
                      if (page.toInt() == _contents.length - 1) {
                        return FilledButton(
                          onPressed: () => _navigateToSignIn(context),
                          child: Text('Inizia'),
                        );
                      }

                      return FilledButton(
                        onPressed: () {
                          _pageController.animateToPage(
                            page.toInt() + 1,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text('Avanti'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  void _onScroll() {
    _notifier.value = _pageController.page ?? 0;
  }

  void _navigateToSignIn(BuildContext context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const SignInPage()));
  }
}
