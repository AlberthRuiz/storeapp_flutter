import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/pages/empty_page.dart';
import 'package:storeapp_flutter/provider/cart_provider.dart';
import 'package:storeapp_flutter/provider/products_provider.dart';
import 'package:storeapp_flutter/utils/global_actions.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/cart_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';
import 'package:uuid/uuid.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    return cartItemsList.isEmpty
        ? const EmptyPage(
            title: 'Carrito vacio',
            subtitle: 'Agregar un producto',
            buttonText: 'Comprar',
            imagePath: 'assets/images/empty-cart.png',
          )
        : Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: TextWidget(
                  text: 'Carrito (${cartItemsList.length})',
                  color: color,
                  isTitle: true,
                  textSize: 22,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      GlobalActions.warningDialog(
                          title: 'Eliminar?',
                          subtitle: 'Esta seguro?',
                          fct: () async {
                            await cartProvider.clearOnlineCart();
                            cartProvider.clearLocalCart();
                          },
                          context: context);
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ),
                  ),
                ]),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _comprar(context: context),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItemsList.length,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                          value: cartItemsList[index],
                          child: CartWidget(
                            q: cartItemsList[index].cantidad,
                          ));
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Widget _comprar({required BuildContext context}) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);

    double total = 0.0;
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrProduct = productProvider.findProdById(value.idproducto);
      total += (getCurrProduct.esOferta
              ? getCurrProduct.precioVenta
              : getCurrProduct.precio) *
          value.cantidad;
    });
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      // color: ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(children: [
          Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                User? user = firebaseAuth.currentUser;
                final idOrden = const Uuid().v4();
                final productProvider =
                    Provider.of<ProductsProvider>(context, listen: false);
                cartProvider.getCartItems.forEach((key, value) async {
                  final getCurrProduct = productProvider.findProdById(
                    value.idproducto,
                  );
                  try {
                    await FirebaseFirestore.instance
                        .collection('orders')
                        .doc(idOrden)
                        .set({
                      'idOrden': idOrden,
                      'idusuario': user!.uid,
                      'idproducto': value.idproducto,
                      'precio': (getCurrProduct.esOferta
                              ? getCurrProduct.precioVenta
                              : getCurrProduct.precio) *
                          value.cantidad,
                      'precioTotal': total,
                      'cantidad': value.cantidad,
                      'imageUrl': getCurrProduct.imageUrl,
                      'nombre': user.displayName,
                      'fechaOrden': Timestamp.now(),
                    });
                    await cartProvider.clearOnlineCart();
                    cartProvider.clearLocalCart();
                    await Fluttertoast.showToast(
                      msg: "Tu orden fue enviada!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                  } catch (error) {
                    GlobalActions.errorDialog(
                        subtitle: error.toString(), context: context);
                  } finally {}
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: 'Order Now',
                  textSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Spacer(),
          FittedBox(
            child: TextWidget(
              text: 'Total: S/. ${total.toStringAsFixed(2)}',
              color: color,
              textSize: 18,
              isTitle: true,
            ),
          ),
        ]),
      ),
    );
  }
}
