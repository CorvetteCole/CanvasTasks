@JS()
library cache;

import 'dart:js';

import 'package:js/js.dart';

@JS()
class CacheService {
  external Cache getDocumentCache();

  external Cache getScriptCache();

  external Cache getUserCache();
}

@JS()
class Cache {
  external String get(String key);

  external JsObject getAll(List<String> keys);

  external void put(String key, String value, [num expirationInSeconds]);

  external void putAll(Map<String, String> values, [num expirationInSeconds]);

  external void remove(String key);

  external void removeAll(List<String> keys);
}
