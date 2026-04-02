import 'package:chat/core/enum/app_theme.dart';
import 'package:chat/core/style/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {

  static final SettingsManager _instance = SettingsManager._internal(); // Singleton instance
  factory SettingsManager() => _instance; // Factory returns the same instance
  SettingsManager._internal();

  static SharedPreferences? _prefs;

  // Keys
  final String _themeKey = "app_theme";
  final String _fontSizeKey = "font_size_scale";
  final String _wallpaperKey = "selected_wallpaper";

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // --- THEME LOGIC ---
  AppTheme get getTheme => AppTheme.values.firstWhere(
    (t) => t.name == _prefs?.getString(_themeKey),
    orElse: () => AppTheme.light
  );
  Future<void> setTheme(AppTheme theme) async => await _prefs?.setString(_themeKey, theme.name);

  // --- TEXT SIZE LOGIC ---
  double get getTextScale => _prefs?.getDouble(_fontSizeKey) ?? 1.0;
  Future<void> setTextScale(double scale) async => await _prefs?.setDouble(_fontSizeKey, scale);

  // --- WALLPAPER LOGIC ---
  String get getWallpaper => _prefs?.getString(_wallpaperKey) ?? "";
  Future<void> setWallpaper(String path) async => await _prefs?.setString(_wallpaperKey, path);

}