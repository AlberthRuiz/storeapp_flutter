import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderModel extends ChangeNotifier {
  final String idOrden, idusuario, idproducto, nombre, precio, imageUrl, cantidad;
  final Timestamp fechaOrden;

  OrderModel(
      {required this.idOrden,
      required this.idusuario,
      required this.idproducto,
      required this.nombre,
      required this.precio,
      required this.imageUrl,
      required this.cantidad,
      required this.fechaOrden});
}
