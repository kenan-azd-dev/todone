import 'package:flutter/material.dart';

// Packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horizontal_blocked_scroll_physics/horizontal_blocked_scroll_physics.dart';
import 'package:username/username.dart';

// Project
part 'onboarding_state.dart';

/// {@template onboarding_cubit}
/// Manages the state and logic for the onboarding process.
/// {@endtemplate}
class OnboardingCubit extends Cubit<OnboardingState> {
  /// {@macro onboarding_cubit}
  OnboardingCubit(UsernameRepository usernameRepository)
      : _usernameRepository = usernameRepository,
        super(const OnboardingState());

  /// Provides access to the internal page controller
  /// for managing the onboarding screen.
  final _pageController = PageController();

  final UsernameRepository _usernameRepository;

  PageController get pageController => _pageController;

  /// Called when the current page of the onboarding flow changes.
  void onPageChanged(int page) {
    emit(state.copyWith(
      currentPage: page,
      status: OnboardingStatus.pageChanged,
    ));
  }

  /// Called when the user enters text in the username field.
  void onFieldChanged(String value) {
    validateTextField(value);
    emit(state.copyWith(
      username: value,
    ));
  }

  /// Gets the [ScrollPhysics] based on the current page,
  /// and the validity of the username.
  /// if the current page is 3 and the username is not valid,
  /// then we will use [LeftBlockedScrollPhysics] to block the
  /// user from continuing without entering their name. otherwise
  /// we will use [AlwaysScrollableScrollPhysics].
  ScrollPhysics getScrollPhysics() {
    return !state.isValidName && state.currentPage == 2
        ? const LeftBlockedScrollPhysics()
        : const AlwaysScrollableScrollPhysics();
  }

  /// Validates the provided username.
  void validateTextField(String text) {
    bool isValid = text.isNotEmpty && text.length > 2;
    emit(state.copyWith(
      isValidName: isValid,
      status: isValid
          ? OnboardingStatus.validationSuccess
          : OnboardingStatus.validationFailure,
    ));
  }

  /// Attempts to proceed to the next onboarding step,
  /// considering validation.
  void proceed(void Function() navigator) {
    if (!state.isValidName && state.currentPage == 2) {
      return;
    }

    if (state.currentPage == 3) {
      saveUsername();
      navigator();
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  /// Saves the entered username to the provided username repository.
  void saveUsername() {
    if (state.username.isNotEmpty && state.username.length > 2) {
      try {
        _usernameRepository.setUsername(state.username);
      } catch (e) {
        emit(state.copyWith(status: OnboardingStatus.validationFailure));
      }
    }
  }

  @override
  Future<void> close() {
    _pageController.dispose();
    return super.close();
  }
}
