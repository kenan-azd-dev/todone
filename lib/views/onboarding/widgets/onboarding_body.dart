import 'package:flutter/material.dart';

// Packages
import 'package:todone/common/common.dart';
import 'package:todone/l10n/l10n.dart';

// Project
import '../../home/home.dart';
import '../onboarding.dart';

part 'progress_button.dart';

/// {@template onboarding_body}
/// The Body of the OnboardingPage.
/// {@endtemplate}
class OnboardingBody extends StatelessWidget {
  /// {@macro onboarding_body}
  const OnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: PageView(
                physics: context.read<OnboardingCubit>().getScrollPhysics(),
                controller: context.read<OnboardingCubit>().pageController,
                onPageChanged: (value) =>
                    context.read<OnboardingCubit>().onPageChanged(value),
                children: OnboardingConstants.pages(context),
              ),
            ),
            _ProgressButton(
              index: state.currentPage,
              label: l10n.onBoardingNext,
            )
          ],
        );
      },
    );
  }
}
