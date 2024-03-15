import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  final userCollection = FirebaseFirestore.instance.collection('users');
  Future<void> fetchCart() async {
    final User? user = firebaseAuth.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();

    final leng = await userDoc.get('carrito').length;
    for (int i = 0; i < leng; i++) {
      _cartItems.putIfAbsent(
          userDoc.get('carrito')[i]['productId'],
          () => CartModel(
                id: userDoc.get('carrito')[i]['cartId'],
                productId: userDoc.get('carrito')[i]['productId'],
                quantity: userDoc.get('carrito')[i]["cantidad"],
              ));
    }
    notifyListeners();
  }

  void reduceQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity - 1,
      ),
    );

    notifyListeners();
  }

  void increaseQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity + 1,
      ),
    );
    notifyListeners();
  }

  Future<void> removeOneItem(
      {required String cartId,
      required String productId,
      required int quantity}) async {
    final User? user = firebaseAuth.currentUser;
    await userCollection.doc(user!.uid).update({
      'carrito': FieldValue.arrayRemove([
        {'cartId': cartId, 'productId': productId, "cantidad": quantity}
      ])
    });
    _cartItems.remove(productId);
    await fetchCart();
    notifyListeners();
  }

  Future<void> clearOnlineCart() async {
    final User? user = firebaseAuth.currentUser;
    await userCollection.doc(user!.uid).update({
      'carrito': [],
    });
    _cartItems.clear();
    notifyListeners();
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
