class AppConfig {

  static AppConfig? _instance;

  final String baseUrl;
  final String baseUrlWs;
  final String environment;

  // private constructor
  AppConfig._({
    required this.baseUrl,
    required this.baseUrlWs,
    required this.environment
  });

  static void initialize({required String baseUrl, required String baseUrlWs, required String environment}){
    _instance ??= AppConfig._(baseUrl: baseUrl, baseUrlWs: baseUrlWs, environment: environment);
  }

  static AppConfig? get instance {
    if(_instance == null){
      throw Exception("AppConfig is not initialized. Call AppConfig.initialize() first.");
    }
    return _instance;
  }

}