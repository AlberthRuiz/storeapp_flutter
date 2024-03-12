import 'package:flutter/material.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/back_widget.dart';
import 'package:storeapp_flutter/widgets/on_sale_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class OnSalePage extends StatelessWidget {
  static const routName = "/OnSalePage";

  const OnSalePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = false;
    final util = Utils(context);
    return Scaffold(
      appBar: AppBar(
        leading:  BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: "Productos con descuento",
          color: util.color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: _isEmpty
          // ignore: dead_code
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/empty.png",
                      height: 200,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "No hay productos con descuento",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: util.color, fontSize: 20),
                    ),
                  ],
                ),
              ),
            )
          : GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              childAspectRatio:
                  util.getScreenSize.width / (util.getScreenSize.height * 0.55),
              children: List.generate(16, (index) {
                return OnSaleWidget();
              }),
            ),
    );
  }
}
