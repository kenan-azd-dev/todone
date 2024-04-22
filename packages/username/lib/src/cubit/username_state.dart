part of 'username_cubit.dart';

enum UsernameStatus { initial, loading, success, failure }

@immutable
class UsernameState extends Equatable {
  final String username;
  final UsernameStatus status;
  const UsernameState({
    this.username = 'wonderful user',
    this.status = UsernameStatus.initial,
  });

  UsernameState copyWith({
    String? username,
    UsernameStatus? status,
  }) {
    return UsernameState(
      username: username ?? this.username,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [username, status];

  @override
  bool get stringify => true;
}
