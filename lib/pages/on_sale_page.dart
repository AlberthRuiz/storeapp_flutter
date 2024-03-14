import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/models/products_model.dart';
import 'package:storeapp_flutter/provider/products_provider.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/back_widget.dart';
import 'package:storeapp_flutter/widgets/on_sale_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class OnSalePage extends StatelessWidget {
  static const routName = "/OnSalePage";
  final int crossAxisCount = 2;
  const OnSalePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    bool _isEmpty = productsOnSale.length<1;
    final util = Utils(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: "Descuento",
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
                  util.getScreenSize.width / (util.getScreenSize.height * 0.45),
              children: List.generate(productsOnSale.length, (index) {
                return ChangeNotifierProvider.value(
                    value: productsOnSale[index], child: OnSaleWidget());
              }),
            ),
    );
  }
}
