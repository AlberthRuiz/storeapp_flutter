import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final String id, title, imageUrl, productCategoryName;
  final double precio, precioVenta;
  final bool esOferta, isUnd;

  ProductModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.productCategoryName,
      required this.precio,
      required this.precioVenta,
      required this.esOferta,
      required this.isUnd});
}
