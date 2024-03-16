import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/provider/cart_provider.dart';
import 'package:storeapp_flutter/provider/products_provider.dart';
import 'package:storeapp_flutter/provider/viewed_prod_provider.dart';
import 'package:storeapp_flutter/provider/wishlist_provider.dart';
import 'package:storeapp_flutter/utils/global_actions.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/heart_button_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  final String? id;
  const ProductDetailsPage({super.key, this.id});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final _cantidadTextController = TextEditingController(text: '1');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _cantidadTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;

    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final idproducto = widget.id;
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(idproducto!);

    double usedPrice = getCurrProduct.esOferta
        ? getCurrProduct.precioVenta
        : getCurrProduct.precio;
    double precioTotal = usedPrice * int.parse(_cantidadTextController.text);
    bool? isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);

    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);

    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        viewedProdProvider.addProductToHistory(idproducto: idproducto);
      },
      child: Scaffold(
        appBar: AppBar(
            leading: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () =>
                  Navigator.canPop(context) ? Navigator.pop(context) : null,
              child: Icon(
                IconlyLight.arrow_left_2,
                color: color,
                size: 24,
              ),
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        body: Column(children: [
          Expanded(
            flex: 1,
            child: FancyShimmerImage(
              imageUrl: getCurrProduct.imageUrl,
              boxFit: BoxFit.scaleDown,
              width: size.width,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: getCurrProduct.title,
                          color: color,
                          textSize: 25,
                          isTitle: true,
                        ),
                        HeartButtonWidget(
                          idproducto: getCurrProduct.id,
                          isInWishlist: isInWishlist,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: 'S/.${usedPrice.toStringAsFixed(2)}',
                          color: Colors.green,
                          textSize: 22,
                          isTitle: true,
                        ),
                        TextWidget(
                          text: getCurrProduct.isUnd ? '/Und' : '/Kg',
                          color: color,
                          textSize: 12,
                          isTitle: false,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Visibility(
                          visible: getCurrProduct.esOferta ? true : false,
                          child: Text(
                            'S/.${getCurrProduct.precio.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 15,
                                color: color,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(63, 200, 101, 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextWidget(
                            text: 'Envio Gratis',
                            color: Colors.white,
                            textSize: 20,
                            isTitle: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cantidadControl(
                        fct: () {
                          if (_cantidadTextController.text == '1') {
                            return;
                          } else {
                            setState(() {
                              _cantidadTextController.text =
                                  (int.parse(_cantidadTextController.text) - 1)
                                      .toString();
                            });
                          }
                        },
                        icon: CupertinoIcons.minus,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _cantidadTextController,
                          key: const ValueKey("cantidad"),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                          style: TextStyle(color: color, fontSize: 16),
                          textAlign: TextAlign.center,
                          cursorColor: Colors.green,
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          onChanged: (value) {
                            if (!value.isEmpty) {
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      cantidadControl(
                        fct: () {
                          setState(() {
                            _cantidadTextController.text =
                                (int.parse(_cantidadTextController.text) + 1)
                                    .toString();
                          });
                        },
                        icon: CupertinoIcons.plus,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: 'Total',
                                  color: Colors.red.shade300,
                                  textSize: 20,
                                  isTitle: true,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text:
                                            'S/.${precioTotal.toStringAsFixed(2)}/',
                                        color: color,
                                        textSize: 20,
                                        isTitle: true,
                                      ),
                                      TextWidget(
                                        text:
                                            '${_cantidadTextController.text}Kg',
                                        color: color,
                                        textSize: 16,
                                        isTitle: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Center(
                              child: Material(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  onTap: isInCart
                                      ? null
                                      : () async {
                                          final User? user =
                                              firebaseAuth.currentUser;

                                          if (user == null) {
                                            GlobalActions.errorDialog(
                                                subtitle: 'Inicie sesion',
                                                context: context);
                                            return;
                                          }
                                          await GlobalActions.addToCart(
                                              idproducto: getCurrProduct.id,
                                              cantidad: int.parse(
                                                  _cantidadTextController.text),
                                              context: context);
                                          await cartProvider.fetchCart();
                                        },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: TextWidget(
                                          text:
                                              isInCart ? 'Agregado' : 'Agregar',
                                          color: Colors.white,
                                          textSize: 18)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget cantidadControl(
      {required Function fct, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: color,
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            )),
      ),
    );
  }
}
