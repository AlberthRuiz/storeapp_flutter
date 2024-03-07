import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:storeapp_flutter/pages/on_sale_page.dart';
import 'package:storeapp_flutter/pages/product_page.dart';
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
  final List<String> _destacados = [
    "https://images.pexels.com/photos/5632381/pexels-photo-5632381.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://images.pexels.com/photos/7608269/pexels-photo-7608269.jpeg?auto=compress&cs=tinysrgb&w=800",
    "https://media.istockphoto.com/id/1034754206/es/foto/ahorro-descuento-cup%C3%B3n-vale-con-calculadora-cupones-son-maquetas.jpg?s=612x612&w=is&k=20&c=2A7N7r02G4sHZcwK4CEy3DGYeWKRkRuXuz8H0TPn3OM=",
  ];

  @override
  Widget build(BuildContext context) {
    final util = Utils(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: util.getScreenSize.height * 0.30,
              child: Swiper(
                itemBuilder: (context, index) {
                  return Image.network(
                    _destacados[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: _destacados.length,
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
                    height: util.getScreenSize.height * 0.22,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return OnSaleWidget();
                      },
                    ),
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
              childAspectRatio:
                  util.getScreenSize.width / (util.getScreenSize.height * 0.55),
              children: List.generate(4, (index) {
                return ProductItemWidget();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
