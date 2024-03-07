import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key,
      required this.price,
      required this.salePrice,
      required this.textPrice,
      required this.isOnSale});
  final double price, salePrice;
  final String textPrice;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    double userPrice = isOnSale ? salePrice : price;
    return FittedBox(
      child: Row(children: [
        TextWidget(
          text: "S/. ${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}",
          color: const Color.fromARGB(255, 62, 148, 64),
          textSize: 15,
          isTitle: true,
        ),
        const SizedBox(
          width: 5,
        ),
        Visibility(
          visible: isOnSale ? true : false,
          child: Text(
            "S/. ${(price * int.parse(textPrice)).toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 12,
              color: Utils(context).color,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        )
      ]),
    );
  }
}
