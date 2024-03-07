import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/heart_button_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetxState();
}

class _CartWidgetxState extends State<CartWidget> {
  final _cantitadTextController = TextEditingController(text: "1");
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cantitadTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    height: utils.getScreenSize.height * 0.20,
                    width: utils.getScreenSize.width * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FancyShimmerImage(
                      imageUrl:
                          "https://media.istockphoto.com/id/1368847822/es/foto/fruta-naranja-realista-sobre-fondo-blanco-camino-de-recorte.jpg?s=2048x2048&w=is&k=20&c=w-BiYptWAfu35zLHi7V03u3ZYjun0u6ebpbVM6FEE9c=",
                      width: utils.getScreenSize.width * 0.21,
                      height: utils.getScreenSize.height * 0.10,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "Product",
                        color: utils.color,
                        textSize: 18,
                        isTitle: true,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      SizedBox(
                        width: utils.getScreenSize.width * 0.4,
                        child: Row(
                          children: [
                            _cantidadController(
                                f: () {},
                                icono: CupertinoIcons.minus,
                                color: Colors.red),
                            Flexible(
                                flex: 2,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                  controller: _cantitadTextController,
                                  keyboardType: TextInputType.number,
                                  // maxLength: 2,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _cantitadTextController.text =
                                          value.isNotEmpty ? value : "1";
                                    });
                                  },
                                )),
                            _cantidadController(
                                f: () {},
                                icono: CupertinoIcons.plus,
                                color: Colors.green),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        const HearButtonWidget(),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            CupertinoIcons.trash,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          text: "S/.12",
                          color: utils.color,
                          textSize: 18,
                          maxLines: 1,
                          isTitle: true,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cantidadController(
      {required Function f, required IconData icono, required color}) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              f();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icono,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
