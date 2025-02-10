import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../local_storage.dart';

const String _separator = '|';

class SecureLocalStorage extends LocalStorage {
  SecureLocalStorage._(this._storage);

  static final SecureLocalStorage _instance = SecureLocalStorage._(
    const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  );

  final FlutterSecureStorage _storage;

  @override
  Future<bool> addStringToList(String key, String value) async {
    return setStringList(
      key,
      (await getStringList(key) ?? []).toList()..add(value),
    );
  }

  @override
  Future<bool> clear() {
    return _storage.deleteAll().then((_) => true);
  }

  @override
  Future<bool> containsKey(String key) {
    return _storage.containsKey(key: key);
  }

  @override
  Future<bool> getBool(String key, [bool defaultValue = false]) async {
    try {
      String? bool = await _storage.read(key: key);
      return bool == null ? defaultValue : bool == "true";
    } catch (e) {
      throw LocalStorageException.unableToRead(e, key: key, type: "bool");
    }
  }

  @override
  Future<double?> getDouble(String key) async {
    try {
      return double.tryParse((await _storage.read(key: key)) ?? '');
    } catch (e) {
      throw LocalStorageException.unableToRead(e, key: key, type: "double");
    }
  }

  @override
  Future<int?> getInt(String key) async {
    try {
      return int.tryParse((await _storage.read(key: key)) ?? '');
    } catch (e) {
      throw LocalStorageException.unableToRead(e, key: key, type: "int");
    }
  }

  @override
  Future<String?> getString(String key) {
    try {
      return _storage.read(key: key);
    } catch (e) {
      throw LocalStorageException.unableToRead(e, key: key, type: "String");
    }
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    try {
      return ((_storage.read(key: key) as String?) ?? '').split(_separator);
    } catch (e) {
      throw LocalStorageException.unableToRead(
        e,
        key: key,
        type: "List<String>",
      );
    }
  }

  @override
  Future<bool> remove(String key) async {
    return _storage.delete(key: key).then((_) => true);
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
    return _storage.write(key: key, value: value.toString()).then((_) => true);
  }

  @override
  Future<bool> setDouble(String key, double value) {
    return _storage.write(key: key, value: value.toString()).then((_) => true);
  }

  @override
  Future<bool> setInt(String key, int value) {
    return _storage.write(key: key, value: value.toString()).then((_) => true);
  }

  @override
  Future<bool> setString(String key, String value) {
    return _storage.write(key: key, value: value.toString()).then((_) => true);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    return _storage
        .write(key: key, value: value.join(_separator))
        .then((_) => true);
  }

  static Future<SecureLocalStorage> getInstance() => Future.value(_instance);
}
