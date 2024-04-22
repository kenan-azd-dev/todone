import 'package:flutter/material.dart';

// Packages
import 'package:username/username.dart';

// Project
import '../onboarding.dart';

/// {@template onboarding_page}
/// The welcoming page in the app.
/// 
/// It's the first page to be displayed to the users
/// when they first launch the app.
/// 
/// Its main purpose is letting the users set their
/// favorite language and theme mode. It also let them
/// enter their name / nickname for a more friendly user
/// experience.
/// {@endtemplate}
class OnboardingPage extends StatelessWidget {
  /// {@macro onboarding_page}
  const OnboardingPage({super.key});

  /// The static route for OnboardingPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const OnboardingPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingCubit(
            context.read<UsernameRepository>(),
          ),
        ),
      ],
      child: const OnboardingView(),
    );
  }
}

/// {@template onboarding_view}
/// Displays the Body of OnboardingView
/// {@endtemplate}
class OnboardingView extends StatelessWidget {
  /// {@macro onboarding_view}
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: OnboardingBody(),
      ),
    );
  }
}
