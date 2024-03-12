import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:storeapp_flutter/utils/utils.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    final util = Utils(context);
    return InkWell(
      borderRadius: BorderRadius.circular(23),
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        IconlyLight.arrow_left_2,
        color: util.color,
      ),
    );
  }
}
