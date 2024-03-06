import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool x = false;

class StyleColor {
  Future<bool> getStatusDark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool("THEMESTATUS") ?? false;
    x = isDark;
    print(x);
    return isDark;
  }
}

Color color = x ? Colors.black : Colors.white;

TextStyle titleStyle =
    TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold);

TextStyle subTitleStyle =
    TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold);

OutlineInputBorder borderFormStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(26),
  borderSide: BorderSide.none,
);
