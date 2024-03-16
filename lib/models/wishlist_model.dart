import 'package:flutter/cupertino.dart';

class WishlistModel with ChangeNotifier {
  final String id, idproducto;

  WishlistModel({
    required this.id,
    required this.idproducto,
  });
}
