import 'package:shared_preferences/shared_preferences.dart';

import '../../local_storage_impl.dart';

/// A local storage implementation using SharedPreferences.
class SharedPreferencesSyncLocalStorage extends LocalStorage {
  SharedPreferencesSyncLocalStorage._();

  static final SharedPreferencesSyncLocalStorage _instance =
      SharedPreferencesSyncLocalStorage._();

  SharedPreferences? _storage;

  /// Adds a string to a list stored under the given key.
  /// If the list does not exist, it will be created.
  ///
  /// Returns `true` if the operation was successful.
  @override
  Future<bool> addStringToList(String key, String value) async {
    return setStringList(
      key,
      (await getStringList(key) ?? []).toList()..add(value),
    );
  }

  /// Clears all data in the storage.
  ///
  /// Returns `true` if the operation was successful.
  @override
  Future<bool> clear() async {
    final storage = await _initializedStorage;

    return storage.clear().then((_) => _);
  }

  /// Checks if the storage contains the given key.
  ///
  /// Returns `true` if the key exists.
  @override
  Future<bool> containsKey(String key) async {
    final storage = await _initializedStorage;

    return storage.containsKey(key);
  }

  /// Retrieves a boolean value stored under the given key.
  ///
  /// Returns the boolean value if it exists, otherwise returns [defaultValue].
  @override
  Future<bool> getBool(String key, [bool defaultValue = false]) async {
    final storage = await _initializedStorage;

    try {
      return storage.getBool(key) ?? defaultValue;
    } catch (e) {
      throw LocalStorageException.unableToRead(e, key: key, type: "bool");
    }
  }

  /// Retrieves a double value stored under the given key.
  ///
  /// Returns the double value if it exists, otherwise returns `null`.
  @override
  Future<double?> getDouble(String key) async {
    final storage = await _initializedStorage;

    try {
      return storage.getDouble(key);
    } catch (e) {
      throw LocalStorageException.unableToRead(e, key: key, type: "double");
    }
  }

  /// Retrieves an integer value stored under the given key.
  ///
  /// Returns the integer value if it exists, otherwise returns `null`.
  @override
  Future<int?> getInt(String key) async {
    final storage = await _initializedStorage;

    try {
      return storage.getInt(key);
    } catch (e) {
      throw LocalStorageException.unableToRead(e, key: key, type: "int");
    }
  }

  /// Retrieves a string value stored under the given key.
  ///
  /// Returns the string value if it exists, otherwise returns `null`.
  @override
  Future<String?> getString(String key) async {
    final storage = await _initializedStorage;

    try {
      return storage.getString(key);
    } catch (e) {
      throw LocalStorageException.unableToRead(e, key: key, type: "String");
    }
  }

  /// Retrieves a list of strings stored under the given key.
  ///
  /// Returns the list of strings if it exists, otherwise returns `null`.
  @override
  Future<List<String>?> getStringList(String key) async {
    final storage = await _initializedStorage;

    try {
      return storage.getStringList(key);
    } catch (e) {
      throw LocalStorageException.unableToRead(
        e,
        key: key,
        type: "List<String>",
      );
    }
  }

  /// Removes the value stored under the given key.
  ///
  /// Returns `true` if the operation was successful.
  @override
  Future<bool> remove(String key) async {
    final storage = await _initializedStorage;

    return storage.remove(key).then((_) => true);
  }

  /// Removes a string from a list stored under the given key.
  ///
  /// Returns `true` if the operation was successful.
  @override
  Future<bool> removeStringFromList(String key, String value) async {
    return setStringList(
      key,
      (await getStringList(key) ?? []).toList()..remove(value),
    );
  }

  /// Stores a boolean value under the given key.
  ///
  /// Returns `true` if the operation was successful.
  @override
  Future<bool> setBool(String key, bool value) async {
    final storage = await _initializedStorage;

    return storage.setBool(key, value).then((_) => true);
  }

  /// Stores a double value under the given key.
  ///
  /// Returns `true` if the operation was successful.
  @override
  Future<bool> setDouble(String key, double value) async {
    final storage = await _initializedStorage;

    return storage.setDouble(key, value).then((_) => true);
  }

  /// Stores an integer value under the given key.
  ///
  /// Returns `true` if the operation was successful.
  @override
  Future<bool> setInt(String key, int value) async {
    final storage = await _initializedStorage;

    return storage.setInt(key, value).then((_) => true);
  }

  /// Stores a string value under the given key.
  ///
  /// Returns `true` if the operation was successful.
  @override
  Future<bool> setString(String key, String value) async {
    final storage = await _initializedStorage;

    return storage.setString(key, value).then((_) => true);
  }

  /// Stores a list of strings under the given key.
  ///
  /// Returns `true` if the operation was successful.
  @override
  Future<bool> setStringList(String key, List<String> value) async {
    final storage = await _initializedStorage;

    return storage.setStringList(key, value).then((_) => true);
  }

  Future<SharedPreferences> get _initializedStorage async {
    _storage ??= await SharedPreferences.getInstance();
    return _storage!;
  }

  static Future<void> init() async {
    _instance._storage ??= await SharedPreferences.getInstance();
  }
}
