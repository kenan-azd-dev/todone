import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:username/username.dart';

class MockUsernameRepository extends Mock implements UsernameRepository {}

void main() {
  group('UsernameCubit', () {
    late MockUsernameRepository mockUsernameRepository;
    late UsernameCubit usernameCubit;

    setUp(() {
      mockUsernameRepository = MockUsernameRepository();
      usernameCubit = UsernameCubit(mockUsernameRepository);
    });

    blocTest<UsernameCubit, UsernameState>(
      'emits [UsernameState.loading, UsernameState.success] when getUsername succeeds',
      build: () {
        when(mockUsernameRepository.getUsername()).thenReturn('user123');
        return usernameCubit;
      },
      act: (cubit) => cubit.getUsername(),
      expect: () => [
        const UsernameState(status: UsernameStatus.loading),
        const UsernameState(username: 'user123', status: UsernameStatus.success),
      ],
    );

    blocTest<UsernameCubit, UsernameState>(
      'emits [UsernameState.loading, UsernameState.failure] when getUsername fails',
      build: () {
        when(mockUsernameRepository.getUsername()).thenThrow(Exception('Failed to get username'));
        return usernameCubit;
      },
      act: (cubit) => cubit.getUsername(),
      expect: () => [
        const UsernameState(status: UsernameStatus.loading),
        const UsernameState(status: UsernameStatus.failure),
      ],
    );

    tearDown(() {
      usernameCubit.close();
    });
  });
}
