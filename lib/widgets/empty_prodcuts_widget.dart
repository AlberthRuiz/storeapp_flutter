import 'package:flutter/material.dart';
import 'package:storeapp_flutter/utils/utils.dart';

class EmptyProdWidget extends StatelessWidget {
  const EmptyProdWidget({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                'assets/images/empty-orders.png',
              ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color, fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
