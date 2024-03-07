import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:storeapp_flutter/utils/utils.dart';

class HearButtonWidget extends StatelessWidget {
  const HearButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    return GestureDetector(
      onTap: () {},
      child: Icon(
        IconlyLight.heart,
        size: 22,
        color: utils.color,
      ),
    );
  }
}
