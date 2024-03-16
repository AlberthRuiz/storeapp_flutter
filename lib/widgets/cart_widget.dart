import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/models/cart_model.dart';
import 'package:storeapp_flutter/pages/product_details_page.dart';
import 'package:storeapp_flutter/provider/cart_provider.dart';
import 'package:storeapp_flutter/provider/products_provider.dart';
import 'package:storeapp_flutter/provider/wishlist_provider.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/heart_button_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key, required this.q}) : super(key: key);
  final int q;
  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _cantidadTextController = TextEditingController();
  @override
  void initState() {
    _cantidadTextController.text = widget.q.toString();
    super.initState();
  }

  @override
  void dispose() {
    _cantidadTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final getCurrProduct = productProvider.findProdById(cartModel.idproducto);
    double usedPrice = getCurrProduct.esOferta
        ? getCurrProduct.precioVenta
        : getCurrProduct.precio;
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(id: cartModel.idproducto),
          ),
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      height: size.width * 0.25,
                      width: size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: FancyShimmerImage(
                        imageUrl: getCurrProduct.imageUrl,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: getCurrProduct.title,
                          color: color,
                          textSize: 20,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: Row(
                            children: [
                              _cantidadController(
                                fct: () {
                                  if (_cantidadTextController.text == '1') {
                                    return;
                                  } else {
                                    cartProvider.reduceQuantityByOne(
                                        cartModel.idproducto);
                                    setState(() {
                                      _cantidadTextController.text = (int.parse(
                                                  _cantidadTextController
                                                      .text) -
                                              1)
                                          .toString();
                                    });
                                  }
                                },
                                color: Colors.red,
                                icon: CupertinoIcons.minus,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _cantidadTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'),
                                    ),
                                  ],
                                  onChanged: (v) {
                                    setState(() {
                                      if (v.isEmpty) {
                                        _cantidadTextController.text = '1';
                                      } else {
                                        return;
                                      }
                                    });
                                  },
                                ),
                              ),
                              _cantidadController(
                                fct: () {
                                  cartProvider.increaseQuantityByOne(
                                      cartModel.idproducto);
                                  setState(() {
                                    _cantidadTextController.text = (int.parse(
                                                _cantidadTextController.text) +
                                            1)
                                        .toString();
                                  });
                                },
                                color: Colors.green,
                                icon: CupertinoIcons.plus,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              await cartProvider.removeOneItem(
                                cartId: cartModel.id,
                                idproducto: cartModel.idproducto,
                                cantidad: cartModel.cantidad,
                              );
                            },
                            child: const Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          HeartButtonWidget(
                            idproducto: getCurrProduct.id,
                            isInWishlist: isInWishlist,
                          ),
                          TextWidget(
                            text:
                                'S/.${(usedPrice * int.parse(_cantidadTextController.text)).toStringAsFixed(2)}',
                            color: color,
                            textSize: 18,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cantidadController({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
