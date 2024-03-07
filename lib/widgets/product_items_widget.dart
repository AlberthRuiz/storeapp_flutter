import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/heart_button_widget.dart';
import 'package:storeapp_flutter/widgets/price_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({super.key});

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  final _cantidadControlller = TextEditingController();
  @override
  void initState() {
    _cantidadControlller.text = "1";
    super.initState();
  }

  @override
  void dispose() {
    _cantidadControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        clipBehavior: Clip.none,
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
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: "Naranja",
                      color: utils.color,
                      textSize: 20,
                      isTitle: true,
                    ),
                    HearButtonWidget(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceWidget(
                        price: 12,
                        salePrice: 13,
                        textPrice: _cantidadControlller.text,
                        isOnSale: true),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  value = "1";
                                }
                                _cantidadControlller.text = value;
                              });
                            },
                            controller: _cantidadControlller,
                            key: const ValueKey("10"),
                            style: TextStyle(color: utils.color, fontSize: 16),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            enabled: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp("[0-9.]"),
                              ),
                            ],
                          )),
                          FittedBox(
                            child: TextWidget(
                              text: "KG",
                              color: utils.color,
                              textSize: 16,
                              isTitle: true,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: utils.getScreenSize.width,
                child: TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    text: "Agregar +",
                    maxLines: 1,
                    color: utils.color,
                    textSize: 18,
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).cardColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
