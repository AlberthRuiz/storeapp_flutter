import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/heart_button_widget.dart';
import 'package:storeapp_flutter/widgets/price_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class OnSaleWidget extends StatefulWidget {
  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.8),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl:
                          "https://media.istockphoto.com/id/1368847822/es/foto/fruta-naranja-realista-sobre-fondo-blanco-camino-de-recorte.jpg?s=2048x2048&w=is&k=20&c=w-BiYptWAfu35zLHi7V03u3ZYjun0u6ebpbVM6FEE9c=",
                      width: utils.getScreenSize.width * 0.20,
                      height: utils.getScreenSize.height * 0.10,
                      boxFit: BoxFit.fitWidth,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Column(
                      children: [
                        TextWidget(
                          text: "1KG",
                          color: utils.color,
                          textSize: 20,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                IconlyLight.buy,
                                size: 22,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            HearButtonWidget(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const PriceWidget(
                    price: 12, salePrice: 13, textPrice: "1", isOnSale: true),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  text: "Titulo Producto",
                  color: utils.color,
                  textSize: 16,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
