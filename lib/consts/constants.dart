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

class Consts {
  static final List<String> destacados = [
    "https://images.pexels.com/photos/5632381/pexels-photo-5632381.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/7608269/pexels-photo-7608269.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://media.istockphoto.com/id/1034754206/es/foto/ahorro-descuento-cup%C3%B3n-vale-con-calculadora-cupones-son-maquetas.jpg?s=612x612&w=is&k=20&c=2A7N7r02G4sHZcwK4CEy3DGYeWKRkRuXuz8H0TPn3OM=",
  ];
}
