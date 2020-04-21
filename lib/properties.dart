@JS()
library properties;

//import 'dart:js';

import 'package:js/js.dart';

@JS()
class PropertiesService {
  external Properties getDocumentProperties();
  external Properties getScriptProperties();
  external Properties getUserProperties();
}

@JS()
class Properties {
  external Properties deleteAllProperties();
  external Properties deleteProperty(String key);
  external List<String> getKeys();
  external Object getProperties();
  external String getProperty(String key);
  external Properties setProperties(Properties properties);
  external Properties setProperty(String key, String value);
}