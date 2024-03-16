import 'package:flutter/material.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key,
      required this.precio,
      required this.precioVenta,
      required this.textPrice,
      required this.esOferta});
  final double precio, precioVenta;
  final String textPrice;
  final bool esOferta;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    double userPrice = esOferta ? precioVenta : precio;
    return FittedBox(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          text: 'S/.${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}',
          color: Colors.green,
          textSize: 14,
        ),
        const SizedBox(
          width: 5,
        ),
        Visibility(
          visible: esOferta ? true : false,
          child: Text(
            'S/.${(precio * int.parse(textPrice)).toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 12,
              color: color,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
      ],
    ));
  }
}
