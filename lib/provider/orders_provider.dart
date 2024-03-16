import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:storeapp_flutter/models/orders_model.dart';

class OrdersProvider extends ChangeNotifier {
  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var uid = user!.uid;
    _orders = [];
    var ordersSnapshot = await FirebaseFirestore.instance
        .collection("orders")
        .where('idusuario', isEqualTo: uid)        
        .get();
    for (var element in ordersSnapshot.docs) {
      _orders.insert(
        0,
        OrderModel(
          idOrden: element.get("idOrden"),
          idusuario: element.get('idusuario'),
          idproducto: element.get('idproducto'),
          nombre: element.get("nombre"),
          precio: element.get("precio").toString(),
          imageUrl: element.get('imageUrl'),
          cantidad: element.get("cantidad").toString(),
          fechaOrden: element.get("fechaOrden"),
        ),
      );
    }

    notifyListeners();
  }
}
