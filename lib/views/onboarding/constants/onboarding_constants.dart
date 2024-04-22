import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

// Packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:language_api/language_api.dart';

// Project
import 'package:todone/common/common.dart';
import 'package:todone/l10n/l10n.dart';
import '../onboarding.dart';

class OnboardingConstants {
  static const String welcomeSvgPath = 'assets/svg/onboard_welcome.svg';
  static const String getStartedSvgPath = 'assets/svg/onboard_get_started.svg';

  static const int numOfPages = 4;

  static List<Widget> pages(BuildContext context) {
    final l10n = context.l10n;
    List<Widget> pages = [
      OnboardPage(
        title: l10n.onBoardingWelcome,
        widgets: [
          SizedBox(
            width: double.maxFinite,
            child: SvgPicture.asset(OnboardingConstants.welcomeSvgPath),
          )
        ],
        description: l10n.onBoardingWelcomeMessage,
      ),
      OnboardPage(
        title: l10n.onBoardingPreferences,
        widgets: [
          Column(
            children: [
              LanguageDropDownFormField(hintText: l10n.settingsChangeLanguage),
              ViewsConstant.gap12,
              ThemeDropDown(hintText: l10n.settingsChangeTheme),
            ],
          )
        ],
        description: l10n.onBoardingPreferencesMessage,
      ),
      OnboardPage(
        title: l10n.onBoardingName,
        widgets: [
          UsernameTextField(
            onChanged: (value) =>
                context.read<OnboardingCubit>().onFieldChanged(value),
            initialValue: context.read<OnboardingCubit>().state.username,
          )
        ],
        description: l10n.onBoardingNameMessage,
      ),
      OnboardPage(
        title: l10n.onBoardingAllSet,
        widgets: [SvgPicture.asset(OnboardingConstants.getStartedSvgPath)],
        description: l10n.onBoardingEnjoyApp,
      ),
    ];

    return pages;
  }
}
