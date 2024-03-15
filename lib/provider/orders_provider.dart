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
    await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .orderBy("ferchaPedido", descending: false)
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _orders = [];
      // _orders.clear();
      for (var element in ordersSnapshot.docs) {
        _orders.insert(
          0,
          OrderModel(
            orderId: element.get("idPedido"),
            userId: element.get('userId'),
            productId: element.get('productId'),
            userName: element.get("nombreUsuario"),
            price: element.get("precio").toString(),
            imageUrl: element.get('imageUrl'),
            quantity: element.get("cantidad").toString(),
            orderDate: element.get("ferchaPedido"),
          ),
        );
      }
    });
    notifyListeners();
  }
}
