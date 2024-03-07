import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/cart_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final util = Utils(context);
    return Scaffold(
        appBar: AppBar(
          title: TextWidget(
            text: "Mi Carrito",
            color: util.color,
            textSize: 24,
            isTitle: true,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(IconlyBold.delete))
          ],
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return CartWidget();
          },
        ));
  }
}
