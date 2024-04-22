import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

/// {@template username_repository}
/// A repository for providing access to username.
/// 
/// It uses [SharedPreferences] for local storage,
/// and provides two methods: [getUsername] and
/// [setUsername].
/// {@endtemplate}
class UsernameRepository {
  /// {@macro username_repository}
  const UsernameRepository({
    required SharedPreferences plugin,
  }) : _plugin = plugin;

  final SharedPreferences _plugin;

  /// The key used for storing the username locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kUsernameKey = '__username_key__';

  String? getUsername() => _plugin.getString(kUsernameKey);

  Future<void> setUsername(String value) async =>
      await _plugin.setString(kUsernameKey, value);
}
