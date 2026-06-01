import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String themeKey = 'theme';
  static const String searchKey = 'last_search';      
  static const String sortKey = 'last_sort';           

  static Future<void> saveTheme(bool darkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, darkMode);
  }

  static Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey) ?? true;
  }

  static Future<void> saveSearch(String search) async {  // ✅
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(searchKey, search);
  }

  static Future<String> getSearch() async {              // ✅
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(searchKey) ?? '';
  }

  static Future<void> saveSort(String sort) async {      // ✅
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(sortKey, sort);
  }

  static Future<String> getSort() async {                // ✅
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sortKey) ?? 'aToz';
  }
}