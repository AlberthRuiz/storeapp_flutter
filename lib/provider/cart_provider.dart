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

  final userCollection = FirebaseFirestore.instance.collection('usuarios');
  Future<void> fetchCart() async {
    final User? user = firebaseAuth.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    
    final leng = await userDoc.get('carrito').length;
    for (int i = 0; i < leng; i++) {
      _cartItems.putIfAbsent(
          userDoc.get('carrito')[i]['idproducto'],
          () => CartModel(
                id: userDoc.get('carrito')[i]['idCarrito'],
                idproducto: userDoc.get('carrito')[i]['idproducto'],
                cantidad: userDoc.get('carrito')[i]["cantidad"],
              ));
    }
    notifyListeners();
  }

  void reduceQuantityByOne(String idproducto) {
    _cartItems.update(
      idproducto,
      (value) => CartModel(
        id: value.id,
        idproducto: idproducto,
        cantidad: value.cantidad - 1,
      ),
    );

    notifyListeners();
  }

  void increaseQuantityByOne(String idproducto) {
    _cartItems.update(
      idproducto,
      (value) => CartModel(
        id: value.id,
        idproducto: idproducto,
        cantidad: value.cantidad + 1,
      ),
    );
    notifyListeners();
  }

  Future<void> removeOneItem(
      {required String cartId,
      required String idproducto,
      required int cantidad}) async {
    final User? user = firebaseAuth.currentUser;
    await userCollection.doc(user!.uid).update({
      'carrito': FieldValue.arrayRemove([
        {'idCarrito': cartId, 'idproducto': idproducto, "cantidad": cantidad}
      ])
    });
    _cartItems.remove(idproducto);
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
