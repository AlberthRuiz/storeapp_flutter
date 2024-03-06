import 'package:flutter/material.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/catergories_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

// ignore: must_be_immutable
class CategoriesPage extends StatelessWidget {
  List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/images/categories/fruits.png',
      'catText': 'Futras',
    },
    {
      'imgPath': 'assets/images/categories/vegetable.png',
      'catText': 'Vegetales',
    },
    {
      'imgPath': 'assets/images/categories/herbs.png',
      'catText': 'Hierbas',
    },
    {
      'imgPath': 'assets/images/categories/nuts.png',
      'catText': 'Nueces',
    },
    {
      'imgPath': 'assets/images/categories/spices.png',
      'catText': 'Condimentos',
    },
    {
      'imgPath': 'assets/images/categories/grains.png',
      'catText': 'Granos',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: "Categorias",
          color: color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 260 / 250,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(
          6,
          (index) {
            return CategoriesWidget(
                texto: catInfo[index]["catText"],
                image: catInfo[index]["imgPath"],
                passedcolor: gridColors[index]);
          },
        ),
      ),
    );
  }
}
