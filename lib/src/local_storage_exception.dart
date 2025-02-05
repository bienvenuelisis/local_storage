class LocalStorageException {
  LocalStorageException(this.exception, [this.message]);

  factory LocalStorageException.unableToRead(
    dynamic exception, {
    required String key,
    required String type,
  }) =>
      LocalStorageException(
        exception,
        "Unable to read $type type with key $key from local storage.",
      );

  final dynamic exception;
  final String? message;
}
