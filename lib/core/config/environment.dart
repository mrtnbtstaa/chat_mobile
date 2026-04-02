class Environment{
  static const String getEnv = String.fromEnvironment("env");
  static const String getBaseUrl = String.fromEnvironment("base_url_api");
  static const String getBaseUrlWs = String.fromEnvironment("base_ws_url_api");
}