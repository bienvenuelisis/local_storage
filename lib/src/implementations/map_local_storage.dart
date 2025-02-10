import '../../local_storage_impl.dart';

/// A local storage implementation using a simple Map object.
/// This is useful for testing purposes.
class MapLocalStorage extends LocalStorage {
  final Map<String, dynamic> _storage = {};

  @override
  Future<bool> addStringToList(String key, String value) async {
    final list = (await getStringList(key) ?? []).toList();
    list.add(value);
    return setStringList(key, list);
  }

  @override
  Future<bool> clear() async {
    _storage.clear();
    return true;
  }

  @override
  Future<bool> containsKey(String key) async {
    return _storage.containsKey(key);
  }

  @override
  Future<bool> getBool(String key, [bool defaultValue = false]) async {
    return _storage[key] ?? defaultValue;
  }

  @override
  Future<double?> getDouble(String key) async {
    return _storage[key];
  }

  @override
  Future<int?> getInt(String key) async {
    return _storage[key];
  }

  @override
  Future<String?> getString(String key) async {
    return _storage[key];
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    return _storage[key]?.cast<String>();
  }

  @override
  Future<bool> remove(String key) async {
    _storage.remove(key);
    return true;
  }

  @override
  Future<bool> removeStringFromList(String key, String value) async {
    final list = (await getStringList(key) ?? []).toList();
    list.remove(value);
    return setStringList(key, list);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    _storage[key] = value;
    return true;
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    _storage[key] = value;
    return true;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _storage[key] = value;
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _storage[key] = value;
    return true;
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    _storage[key] = value;
    return true;
  }
}
