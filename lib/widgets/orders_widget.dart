import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:storeapp_flutter/pages/product_details_page.dart';
import 'package:storeapp_flutter/utils/utils.dart';

import '../../widgets/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return ListTile(
      subtitle: const Text('Paid: S/.12.8'),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(),
            ));
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(text: 'Title  x12', color: color, textSize: 18),
      trailing: TextWidget(text: '03/08/2022', color: color, textSize: 18),
    );
  }
}
