import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:username/username.dart';

// Create a Mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {
  @override
  Future<bool> setString(String key, String value) {
    return super.noSuchMethod(
      Invocation.method(
          #setString, [key, value]),
      returnValue: Future<bool>.value(true),
    );
  }
}

void main() {
  group('UsernameRepository', () {
    late MockSharedPreferences mockSharedPreferences;
    late UsernameRepository usernameRepository;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      usernameRepository = UsernameRepository(plugin: mockSharedPreferences);
    });

    test('should return null when there is no username', () {
      // Arrange
      when(mockSharedPreferences.getString(UsernameRepository.kUsernameKey))
          .thenReturn(null);

      // Act
      final result = usernameRepository.getUsername();

      // Assert
      expect(result, isNull);
      verify(mockSharedPreferences.getString(UsernameRepository.kUsernameKey))
          .called(1);
    });

    test('should return username when there is one saved', () {
      // Arrange
      const username = 'john_doe';
      when(mockSharedPreferences.getString(UsernameRepository.kUsernameKey))
          .thenReturn(username);

      // Act
      final result = usernameRepository.getUsername();

      // Assert
      expect(result, username);
      verify(mockSharedPreferences.getString(UsernameRepository.kUsernameKey))
          .called(1);
    });

    test('should call SharedPreferences to save the username', () async {
      // Arrange
      const username = 'john_doe';
      when(mockSharedPreferences.setString(
              UsernameRepository.kUsernameKey, username))
          .thenAnswer((_) async => true);

      // Act
      await usernameRepository.setUsername(username);

      // Assert
      verify(mockSharedPreferences.setString(
              UsernameRepository.kUsernameKey, username))
          .called(1);
    });
  });
}
