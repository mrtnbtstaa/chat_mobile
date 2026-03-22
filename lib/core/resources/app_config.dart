class AppConfig {

  static AppConfig? _instance;

  final String baseUrl;
  final String environment;

  // private constructor
  AppConfig._({
    required this.baseUrl,
    required this.environment
  });

  static void initialize({required String baseUrl, required String environment}){
    _instance ??= AppConfig._(baseUrl: baseUrl, environment: environment);
  }

  static AppConfig? get instance {
    if(_instance == null){
      throw Exception("AppConfig is not initialized. Call AppConfig.initialize() first.");
    }
    return _instance;
  }

}