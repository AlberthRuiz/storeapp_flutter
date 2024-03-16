import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier {
  final String id, idproducto;
  final int cantidad;

  CartModel({
    required this.id,
    required this.idproducto,
    required this.cantidad,
  });
}
