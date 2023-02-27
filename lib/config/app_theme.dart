import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme{

  //Added TextStyles by Yash

  final headText1 =   GoogleFonts.comicNeue(
    color: Colors.white,
    decoration: TextDecoration
        .none,

    fontSize: 40,
  );
  final headText2 =  GoogleFonts.catamaran(
    color: Colors.white,
    decoration: TextDecoration
        .none,

    fontSize: 16,
  );

  static final darkTheme = ThemeData(

  );

  static final lightTheme = ThemeData(

  );

}

class selectedAppTheme {

  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future saveMode(bool mode) async =>
      await _preferences?.setBool('_isDark', mode);

  static bool? getMode() => _preferences?.getBool('_isDark');
  static bool isDarkMode = selectedAppTheme.getMode()?? false;
}