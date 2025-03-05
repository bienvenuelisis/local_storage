# Local Storage

A local storage implementation using `SharedPreferences`, `SharedPreferencesSync`, `FlutterSecureStorage`, or any other local storage implementation for Flutter applications.

## Features

- Store and retrieve various data types (String, int, double, bool, List `<String>`)
- Add and remove strings from a list stored under a given key
- Check if a key exists in the storage
- Clear all data in the storage
- Use an interface to switch between different storage implementations (`SharedPreferences`, `SharedPreferencesSync`, `FlutterSecureStorage`, etc.)
- Use a simple `Map` implementation for testing purposes

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  local_storage_impl: ^0.0.3
```

Then, run `flutter pub get` to install the package.

## Usage

### Initialization

Before using the `LocalStorage` interface, you need to initialize the desired implementation (`SharedPreferencesLocalStorage`, `SecureLocalStorage`, or `MapLocalStorage`) and register it with `get_it`:

```dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:local_storage_impl/local_storage_impl.dart';

final getIt = GetIt.instance;

void setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferencesLocalStorage = await SharedPreferencesLocalStorage.getInstance();
  // Or use SecureLocalStorage
  // final secureLocalStorage = await SecureLocalStorage.getInstance();
  
  getIt.registerSingleton<LocalStorage>(sharedPreferencesLocalStorage);
  // Or register SecureLocalStorage
  // getIt.registerSingleton<LocalStorage>(secureLocalStorage);
}

void main() async {
  await setup();
  runApp(MyApp());
}
```

### Storing Data

You can store various data types using the provided methods:

```dart
final localStorage = GetIt.instance<LocalStorage>();

// Store a string
await localStorage.setString('key', 'value');

// Store an integer
await localStorage.setInt('key', 123);

// Store a double
await localStorage.setDouble('key', 123.45);

// Store a boolean
await localStorage.setBool('key', true);

// Store a list of strings
await localStorage.setStringList('key', ['value1', 'value2']);
```

### Retrieving Data

You can retrieve the stored data using the corresponding methods:

```dart
final localStorage = GetIt.instance<LocalStorage>();

// Retrieve a string
String? value = await localStorage.getString('key');

// Retrieve an integer
int? intValue = await localStorage.getInt('key');

// Retrieve a double
double? doubleValue = await localStorage.getDouble('key');

// Retrieve a boolean
bool boolValue = await localStorage.getBool('key', defaultValue: false);

// Retrieve a list of strings
List<String>? stringList = await localStorage.getStringList('key');
```

### Other Operations

You can also perform other operations such as checking if a key exists, removing a key, and clearing all data:

```dart
final localStorage = GetIt.instance<LocalStorage>();

// Check if a key exists
bool containsKey = await localStorage.containsKey('key');

// Remove a key
await localStorage.remove('key');

// Clear all data
await localStorage.clear();
```

### Using `MapLocalStorage` for Testing

For testing purposes, you can use the `MapLocalStorage` implementation, which uses an in-memory `Map` object:

```dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:local_storage_impl/local_storage_impl.dart';

final getIt = GetIt.instance;

void setup() {
  final mapLocalStorage = MapLocalStorage();
  getIt.registerSingleton<LocalStorage>(mapLocalStorage);
}

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Local Storage Example')),
        body: Center(
          child: Text('Local Storage Example'),
        ),
      ),
    );
  }
}
```

### Switching Implementations

You can easily switch between different storage implementations by changing the initialization:

```dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:local_storage_impl/local_storage_impl.dart';

final getIt = GetIt.instance;

void setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Use SecureLocalStorage instead
  final localStorage = await SecureLocalStorage.getInstance();
  getIt.registerSingleton<LocalStorage>(localStorage);
}

void main() async {
  await setup();
  runApp(MyApp());
}
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on GitHub.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
