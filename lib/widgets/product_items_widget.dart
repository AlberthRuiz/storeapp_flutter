import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:storeapp_flutter/utils/utils.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({super.key});

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            FancyShimmerImage(
              imageUrl:
                  "https://media.istockphoto.com/id/1368847822/es/foto/fruta-naranja-realista-sobre-fondo-blanco-camino-de-recorte.jpg?s=2048x2048&w=is&k=20&c=w-BiYptWAfu35zLHi7V03u3ZYjun0u6ebpbVM6FEE9c=",
              width: utils.getScreenSize.width * 0.21,
              height: utils.getScreenSize.height * 0.10,
              boxFit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }
}
