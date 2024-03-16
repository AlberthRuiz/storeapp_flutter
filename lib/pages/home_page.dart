import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/models/products_model.dart';

import 'package:storeapp_flutter/pages/on_sale_page.dart';
import 'package:storeapp_flutter/pages/product_page.dart';
import 'package:storeapp_flutter/provider/products_provider.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/on_sale_widget.dart';
import 'package:storeapp_flutter/widgets/product_items_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final util = Utils(context);
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: util.getScreenSize.height * 0.30,
              child: Swiper(
                itemBuilder: (context, index) {
                  return Image.network(
                    Consts.destacados[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: Consts.destacados.length,
                pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.blueGrey,
                    )),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OnSalePage()));
                },
                child: TextWidget(
                  text: "Ver todos",
                  maxLines: 1,
                  color: util.getTheme ? Colors.white : Colors.blueAccent,
                  textSize: 20,
                  isTitle: true,
                )),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      TextWidget(
                        text: "Descuentos".toUpperCase(),
                        color: Colors.red,
                        textSize: 20,
                        isTitle: true,
                      ),
                      Icon(
                        IconlyLight.discount,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: SizedBox(
                    height: util.getScreenSize.height * 0.27,
                    child: ListView.builder(
                        itemCount: productsOnSale.length < 10
                            ? productsOnSale.length
                            : 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return ChangeNotifierProvider.value(
                              value: productsOnSale[index],
                              child: OnSaleWidget());
                        }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Productos",
                    color: util.color,
                    textSize: 20,
                    isTitle: true,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsPage()));
                    },
                    child: TextWidget(
                      text: "Ver Todos",
                      color: Colors.blueAccent,
                      textSize: 20,
                      maxLines: 1,
                      isTitle: true,
                    ),
                  )
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              childAspectRatio: 260 / 310,
              children: List.generate(
                  allProducts.length < 4
                      ? allProducts.length // length 3
                      : 4, (index) {
                return ChangeNotifierProvider.value(
                  value: allProducts[index],
                  child: ProductItemWidget(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
