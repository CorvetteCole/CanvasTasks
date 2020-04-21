@JS()
library url_fetch;

import 'dart:html';
//import 'dart:js';

import 'package:js/js.dart';

@JS()
class HTTPResponse {
  external Object getAllHeaders();
  external Blob getAs(String contentType);
  external Blob getBlob();
  external List<int> getContent();
  external String getContentText([String charset]);
  external Object geHeaders();
  external int getResponseCode();
}

@JS()
class UrlFetchApp {
  external static HTTPResponse fetch(String url, [Object params]);
  external static List<HTTPResponse> fetchAll(Object requests);
  external static Object getRequest(String url, [Object params]);
}