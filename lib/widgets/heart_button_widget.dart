import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/provider/products_provider.dart';
import 'package:storeapp_flutter/provider/wishlist_provider.dart';
import 'package:storeapp_flutter/utils/global_actions.dart';
import 'package:storeapp_flutter/utils/utils.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget(
      {Key? key, required this.idproducto, this.isInWishlist = false})
      : super(key: key);
  final String idproducto;
  final bool? isInWishlist;

  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidget();
}

class _HeartButtonWidget extends State<HeartButtonWidget> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(widget.idproducto);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () async {
        setState(() {
          loading = true;
        });
        try {
          final User? user = firebaseAuth.currentUser;
          if (user == null) {
            GlobalActions.errorDialog(
                subtitle: 'Usuario no registrado', context: context);
            return;
          }
          if (widget.isInWishlist == false && widget.isInWishlist != null) {
            await GlobalActions.addToWishlist(
                idproducto: widget.idproducto, context: context);
          } else {
            await wishlistProvider.removeOneItem(
                listaId:
                    wishlistProvider.getWishlistItems[getCurrProduct.id]!.id,
                idproducto: widget.idproducto);
          }
          await wishlistProvider.fetchWishlist();
          setState(() {
            loading = false;
          });
        } catch (error) {
          GlobalActions.errorDialog(subtitle: '$error', context: context);
        } finally {
          setState(() {
            loading = false;
          });
        }
      },
      child: loading
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 10, width: 10, child: CircularProgressIndicator()),
            )
          : Icon(
              widget.isInWishlist != null && widget.isInWishlist == true
                  ? IconlyBold.heart
                  : IconlyLight.heart,
              size: 22,
              color: widget.isInWishlist != null && widget.isInWishlist == true
                  ? Colors.red
                  : color,
            ),
    );
  }
}
