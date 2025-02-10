import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage_impl/local_storage_impl.dart';

void main() {
  late MapLocalStorage localStorage;

  setUp(() {
    localStorage = MapLocalStorage();
  });

  test('should store and retrieve a string', () async {
    await localStorage.setString('key', 'value');
    final result = await localStorage.getString('key');
    expect(result, 'value');
  });

  test('should store and retrieve an integer', () async {
    await localStorage.setInt('key', 123);
    final result = await localStorage.getInt('key');
    expect(result, 123);
  });

  test('should store and retrieve a double', () async {
    await localStorage.setDouble('key', 123.45);
    final result = await localStorage.getDouble('key');
    expect(result, 123.45);
  });

  test('should store and retrieve a boolean', () async {
    await localStorage.setBool('key', true);
    final result = await localStorage.getBool('key');
    expect(result, true);
  });

  test('should store and retrieve a list of strings', () async {
    await localStorage.setStringList('key', ['value1', 'value2']);
    final result = await localStorage.getStringList('key');
    expect(result, ['value1', 'value2']);
  });

  test('should add and remove a string from a list', () async {
    await localStorage.setStringList('key', ['value1']);
    await localStorage.addStringToList('key', 'value2');
    var result = await localStorage.getStringList('key');
    expect(result, ['value1', 'value2']);

    await localStorage.removeStringFromList('key', 'value1');
    result = await localStorage.getStringList('key');
    expect(result, ['value2']);
  });

  test('should check if a key exists', () async {
    await localStorage.setString('key', 'value');
    final result = await localStorage.containsKey('key');
    expect(result, true);
  });

  test('should remove a key', () async {
    await localStorage.setString('key', 'value');
    await localStorage.remove('key');
    final result = await localStorage.getString('key');
    expect(result, null);
  });

  test('should clear all data', () async {
    await localStorage.setString('key1', 'value1');
    await localStorage.setString('key2', 'value2');
    await localStorage.clear();
    final result1 = await localStorage.getString('key1');
    final result2 = await localStorage.getString('key2');
    expect(result1, null);
    expect(result2, null);
  });
}
