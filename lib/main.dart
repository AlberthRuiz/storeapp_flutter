import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/pages/on_sale_page.dart';
import 'package:storeapp_flutter/provider/dark_theme_provider.dart';
import 'package:storeapp_flutter/pages/init_page.dart';

import 'consts/theme_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Shop APP",
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: IntiPage(),
          routes: {
            OnSalePage.routName: (ctx) => const OnSalePage(),
          },
        );
      }),
    );
  }
}
