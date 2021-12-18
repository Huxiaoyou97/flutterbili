import 'package:bilibili/db/hi_cache.dart';
import 'package:bilibili/util/color.dart';
import 'package:bilibili/util/hi_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>["System", "Light", "Dark"][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode;

  // 获取主题的模式
  ThemeMode getThemeMode() {
    String theme = HiCache.getInstance().get(HiConstants.theme);
    switch (theme) {
      case "Dark":
        _themeMode = ThemeMode.dark;
        break;
      case "System":
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode;
  }

  // 设置主题
  void setTheme(ThemeMode themeMode) {
    HiCache.getInstance().setString(HiConstants.theme, themeMode.value);
    notifyListeners();
  }

  // 获取主题
  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      errorColor: isDarkMode ? HiColor.dark_red : HiColor.red,
      primaryColor: isDarkMode ? HiColor.dark_bg : Colors.white,
      accentColor: isDarkMode ? primary[50] : Colors.white,
      // Tab 指示器的颜色
      indicatorColor: isDarkMode ? primary[50] : Colors.white,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? HiColor.dark_bg : Colors.white,
    );

    return themeData;
  }
}
