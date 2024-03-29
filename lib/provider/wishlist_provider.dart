import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/models/wishlist_model.dart';

class WishlistProvider extends ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }



  final userCollection = FirebaseFirestore.instance.collection('usuarios');

  Future<void> fetchWishlist() async {
    final User? user = firebaseAuth.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();

    final leng = userDoc.get('lista').length;
    for (int i = 0; i < leng; i++) {
      _wishlistItems.putIfAbsent(
          userDoc.get('lista')[i]['idproducto'],
          () => WishlistModel(
                id: userDoc.get('lista')[i]['listaId'],
                idproducto: userDoc.get('lista')[i]['idproducto'],
              ));
    }
    notifyListeners();
  }

  Future<void> removeOneItem({
    required String listaId,
    required String idproducto,
  }) async {
    final User? user = firebaseAuth.currentUser;
    await userCollection.doc(user!.uid).update({
      'lista': FieldValue.arrayRemove([
        {
          'listaId': listaId,
          'idproducto': idproducto,
        }
      ])
    });
    _wishlistItems.remove(idproducto);
    await fetchWishlist();
    notifyListeners();
  }

  Future<void> clearOnlineWishlist() async {
    final User? user = firebaseAuth.currentUser;
    await userCollection.doc(user!.uid).update({
      'lista': [],
    });
    _wishlistItems.clear();
    notifyListeners();
  }

  void clearLocalWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
