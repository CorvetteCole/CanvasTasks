@JS()
library oauth2;

import 'package:js/js.dart';
import 'cache.dart';
import 'lock.dart';

@JS()
class OAuth2 {
  external static Service_ createService(String serviceName);
  external static String getRedirectUri([String optScriptId]);
  external static List<String> get TOKEN_FORMAT;
}

@JS()
class Service_ {
  external Service_(String serviceName);

  external void exchangeGrant_();

  external Object fetchToken_(Object payload, [String optUrl]);

  external String getAccessToken();

  external String getAuthorizationUrl(Object optAdditionalParameters);

  external String getIdToken();

  external Exception getLastError();

  external String getRedirectUri();

  external Storage_ getStorage();
  external Object getToken([bool optSkipMemoryCheck]); // might not work
  external bool handleCallback(Object callbackRequest);

  external bool hasAccess();

  external void refresh();

  external void reset();

  //external Service_ setAdditionalClaims()  dunno how to implement, not using so not worth spending time on
  external Service_ setAuthorizationBaseUrl(String authorizationBaseUrl);

  external Service_ setCache(Cache cache);
  external Service_ setCallbackFunction(String callbackFunctionName);

  external Service_ setClientId(String clientId);

  external Service_ setClientSecret(String clientSecret);

  external Service_ setExpirationMinutes(String expirationMinutes);

  external Service_ setGrantType(String grantType);

  external Service_ setIssuer(String issuer);

  external Service_ setLock(Lock lock);
  external Service_ setParam(String name, String value);

  external Service_ setPrivateKey(String privateKey);

  external Service_ setPropertyStore(PropertiesService.Properties propertyStore);
  external Service_ setRedirectUri(String redirectUri);

  external Service_ setRefreshUrl(String refreshUrl);

  external Service_ setScope(List<String> scope, String optSeparator);

  external Service_ setSubject(String subject);

  external Service_ setTokenFormat(OAuth2.TOKEN_FORMAT);
  external Service_ setTokenHeaders(Object.<string,string> tokenHeaders);
  external Service_ setTokenPayloadHandler(tokenHandler tokenHandler);
  external Service_ setTokenUrl(String tokenUrl);
}

@JS()
class Storage_ {
  external Storage_(String prefix,
      [PropertiesService.Properties optProperties,
      Cache optCache]);

  external dynamic getValue(String key, [bool optSkipMemoryCheck]); // might not work

  external void removeValue(String key);

  external void removeValueWithPrefixedKey_(String key);

  external void reset(String key);

  external void setValue(String key, dynamic value);
}
