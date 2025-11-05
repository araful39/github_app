// ignore: constant_identifier_names

const String url =
    "https://api.github.com/";

final class NetworkConstants {
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class Endpoints {
  Endpoints._();
  static String userName({required String userName}) => "users/$userName";
  static String userRepos({required String userName}) =>
      '/users/$userName/repos';
}
