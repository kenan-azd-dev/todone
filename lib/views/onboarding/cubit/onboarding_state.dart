part of 'onboarding_cubit.dart';

enum OnboardingStatus {
  initial,
  pageChanged,
  validationFailure,
  validationSuccess,
}

/// {@template onboarding_state}
/// The state for the onboarding process
/// {@endtemplate}
class OnboardingState extends Equatable {
  /// {@macro onboarding_state}
  const OnboardingState({
    this.currentPage = 0,
    this.isValidName = false,
    this.username = '',
    this.status = OnboardingStatus.initial,
  });

  /// The index of the current page.
  final int currentPage;

  /// A tag indicating if the name field is valid.
  /// This is helpful for when you don't want the user
  /// to continue scrolling if the input is required
  /// during the onboarding process.
  final bool isValidName;

  /// The user's username
  ///
  /// Cannot be null or empty.
  final String username;

  /// The current status of the onboarding process.
  final OnboardingStatus status;

  /// Creates a copy of the current OnboardingState with property changes
  OnboardingState copyWith({
    int? currentPage,
    bool? isValidName,
    String? username,
    OnboardingStatus? status,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      isValidName: isValidName ?? this.isValidName,
      username: username ?? this.username,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        currentPage,
        isValidName,
        username,
        status,
      ];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'OnboardingState(currentPage: $currentPage, isValidName: $isValidName, username: $username, status: $status)';
  }
}
