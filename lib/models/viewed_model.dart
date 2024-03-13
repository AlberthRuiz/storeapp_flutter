import 'package:flutter/cupertino.dart';

class ViewedProdModel extends ChangeNotifier {
  final String id, productId;

  ViewedProdModel({
    required this.id,
    required this.productId,
  });
}
