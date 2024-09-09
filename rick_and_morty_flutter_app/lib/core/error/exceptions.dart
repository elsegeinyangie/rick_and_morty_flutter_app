class CacheException implements Exception {}

class CharacterException implements Exception {
  final String message;

  CharacterException(this.message);

   @override
  String toString() => 'CharacterException: $message';
}
