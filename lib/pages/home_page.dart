import 'package:flutter/material.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Center(child: Text("HOME PAGE")),
    );
  }
}
