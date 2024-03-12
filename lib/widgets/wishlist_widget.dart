import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';
import 'package:storeapp_flutter/pages/product_details_page.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/heart_button_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final util = Utils(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(),
            ),
          );
        },
        child: Container(
          height: util.getScreenSize.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.5),
            border: Border.all(color: util.color, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 8,
                ),
                child: FancyShimmerImage(
                  imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                  height: util.getScreenSize.width * 0.21,
                  width: util.getScreenSize.width * 0.2,
                  boxFit: BoxFit.fill,
                ),
              ),
              Column(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(IconlyLight.bag_2),
                          color: util.color,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        HearButtonWidget(),
                      ],
                    ),
                  ),
                  Flexible(
                    child: TextWidget(
                      text: "Titulo",
                      color: util.color,
                      textSize: 18,
                      maxLines: 1,
                      isTitle: true,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    text: "S/. 10",
                    color: util.color,
                    textSize: 18,
                    maxLines: 1,
                    isTitle: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
