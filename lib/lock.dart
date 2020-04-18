@JS()
library lock;

import 'package:js/js.dart';

@JS()
class LockService {
  external Lock getDocumentLock();
  external Lock getScriptLock();
  external Lock getUserLock();
}

@JS()
class Lock {
  external bool hasLock();
  external void releaseLock();
  external bool tryLock(num timeoutInMillis);
  external void waitLock(num timeoutInMillis);
}