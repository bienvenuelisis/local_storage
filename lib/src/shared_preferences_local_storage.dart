import 'package:local_storage/src/local_storage_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.dart';

class SharedPreferencesLocalStorage extends LocalStorage {
  late SharedPreferences _storage;

  @override
  Future<bool> addStringToList(String key, String value) async {
    return setStringList(
      key,
      (await getStringList(key) ?? []).toList()..add(value),
    );
  }

  @override
  Future<bool> clear() {
    return _storage.clear().then((_) => _);
  }

  @override
  Future<bool> containsKey(String key) async {
    return _storage.containsKey(key);
  }

  @override
  Future<bool> getBool(String key, [bool defaultValue = false]) async {
    try {
      return _storage.getBool(key) ?? defaultValue;
    } catch (e) {
      throw LocalStorageException.unableToRead(e, key: key, type: "bool");
    }
  }

  @override
  Future<double?> getDouble(String key) async {
    try {
      return _storage.getDouble(key);
    } catch (e) {
      throw LocalStorageException.unableToRead(e, key: key, type: "double");
    }
  }

  @override
  Future<int?> getInt(String key) async {
    try {
      return _storage.getInt(key);
    } catch (e) {
      throw LocalStorageException.unableToRead(e, key: key, type: "int");
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      return _storage.getString(key);
    } catch (e) {
      throw LocalStorageException.unableToRead(e, key: key, type: "String");
    }
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    try {
      return _storage.getStringList(key);
    } catch (e) {
      throw LocalStorageException.unableToRead(
        e,
        key: key,
        type: "List<String>",
      );
    }
  }

  @override
  Future<void> init() async {
    _storage = await SharedPreferences.getInstance();

    return;
  }

  @override
  Future<bool> remove(String key) async {
    return _storage.remove(key).then((_) => true);
  }

  @override
  Future<bool> removeStringFromList(String key, String value) async {
    return setStringList(
      key,
      (await getStringList(key) ?? []).toList()..remove(value),
    );
  }

  @override
  Future<bool> setBool(String key, bool value) {
    return _storage.setBool(key, value).then((_) => true);
  }

  @override
  Future<bool> setDouble(String key, double value) {
    return _storage.setDouble(key, value).then((_) => true);
  }

  @override
  Future<bool> setInt(String key, int value) {
    return _storage.setInt(key, value).then((_) => true);
  }

  @override
  Future<bool> setString(String key, String value) {
    return _storage.setString(key, value).then((_) => true);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    return _storage.setStringList(key, value).then((_) => true);
  }
}
