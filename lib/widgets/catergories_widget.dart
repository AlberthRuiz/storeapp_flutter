import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/provider/dark_theme_provider.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class CategoriesWidget extends StatelessWidget {
  String texto, image;
  final Color passedcolor;
  CategoriesWidget(
      {required this.texto, required this.image, required this.passedcolor});
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final color = themeState.getDarkTheme ? Colors.white : Colors.black;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        print("presionado");
      },
      child: Container(
        height: _height * 0.25,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: passedcolor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: passedcolor.withOpacity(0.7),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: _width * 0.30,
              height: _height * 0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter),
              ),
            ),
            TextWidget(
              text: texto,
              color: color,
              textSize: 20,
              isTitle: true,
            )
          ],
        ),
      ),
    );
  }
}
