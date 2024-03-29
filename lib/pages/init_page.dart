import 'package:badges/badges.dart' as badge;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/pages/cart_page.dart';
import 'package:storeapp_flutter/pages/categories_page.dart';
import 'package:storeapp_flutter/pages/home_page.dart';
import 'package:storeapp_flutter/pages/user_page.dart';
import 'package:storeapp_flutter/provider/cart_provider.dart';
import 'package:storeapp_flutter/provider/dark_theme_provider.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

// ignore: must_be_immutable
class IntiPage extends StatefulWidget {
  @override
  State<IntiPage> createState() => _BottonBarWidgetState();
}

class _BottonBarWidgetState extends State<IntiPage> {
  List _pages = [
    HomePage(),
    CategoriesPage(),
    CartPage(),
    UserPage(),
  ];
  int _activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor:
          themeState.getDarkTheme ? Color(0xFF00001a) : Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        color: themeState.getDarkTheme ? Color(0xFF00001a) : Colors.white60,
        backgroundColor:
            themeState.getDarkTheme ? Color(0xFF00001a) : Colors.white60,
        buttonBackgroundColor:
            themeState.getDarkTheme ? Color(0xFF00001a) : Colors.white60,
        onTap: (value) {
          _activeIndex = value;
          print(_activeIndex);
          setState(() {});
        },
        items: [
          Icon(_activeIndex == 0 ? IconlyBold.home : IconlyLight.home),
          Icon(_activeIndex == 1 ? IconlyBold.category : IconlyLight.category),
          badge.Badge(
            badgeAnimation: const badge.BadgeAnimation.slide(),
            badgeStyle: badge.BadgeStyle(
              shape: badge.BadgeShape.circle,
              badgeColor: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            position: badge.BadgePosition.topEnd(
              top: -7,
              end: -7,
            ),
            badgeContent: FittedBox(
                child: TextWidget(
                    text: cartProvider.getCartItems.length.toString(),
                    color: Colors.white,
                    textSize: 15)),
            child: Icon(_activeIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
          ),
          Icon(_activeIndex == 3 ? IconlyBold.user_2 : IconlyLight.user),
        ],
      ),
      body: _pages[_activeIndex],
    );
  }
}
