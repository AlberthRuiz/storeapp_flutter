import 'package:flutter/material.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(children: [
        TextWidget(
            text: "1.50",
            color: const Color.fromARGB(255, 62, 148, 64),
            textSize: 22),
        const SizedBox(
          width: 5,
        ),
        Text(
          "2.40",
          style: TextStyle(
            fontSize: 15,
            color: Utils(context).color,
            decoration: TextDecoration.lineThrough,
          ),
        )
      ]),
    );
  }
}
