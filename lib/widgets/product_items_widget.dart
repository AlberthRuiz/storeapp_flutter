import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/models/products_model.dart';
import 'package:storeapp_flutter/pages/product_details_page.dart';
import 'package:storeapp_flutter/provider/cart_provider.dart';
import 'package:storeapp_flutter/provider/products_provider.dart';
import 'package:storeapp_flutter/provider/wishlist_provider.dart';
import 'package:storeapp_flutter/utils/global_actions.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/heart_button_widget.dart';
import 'package:storeapp_flutter/widgets/price_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class ProductItemWidget extends StatefulWidget {
  ProductItemWidget({required this.productModel});
  ProductModel productModel;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  final _cantidadControlller = TextEditingController();
  @override
  void initState() {
    _cantidadControlller.text = "1";
    super.initState();
  }

  @override
  void dispose() {
    _cantidadControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    // final productsProvider = Provider.of<ProductsProvider>(context);
    final productModel = widget.productModel;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(id: productModel.id),
                ));
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(children: [
            FancyShimmerImage(
              imageUrl: productModel.imageUrl,
              height: size.width * 0.21,
              width: size.width * 0.2,
              boxFit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: TextWidget(
                      text: productModel.title,
                      color: color,
                      maxLines: 1,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: HeartButtonWidget(
                        productId: productModel.id,
                        isInWishlist: isInWishlist,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: PriceWidget(
                      salePrice: productModel.salePrice,
                      price: productModel.price,
                      textPrice: _cantidadControlller.text,
                      isOnSale: productModel.isOnSale,
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 6,
                          child: FittedBox(
                            child: TextWidget(
                              text: productModel.isUnd ? 'Und' : 'kg',
                              color: color,
                              textSize: 20,
                              isTitle: true,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                            flex: 2,
                            // TextField can be used also instead of the textFormField
                            child: TextFormField(
                              controller: _cantidadControlller,
                              key: const ValueKey('10'),
                              style: TextStyle(color: color, fontSize: 18),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              enabled: true,
                              onChanged: (valueee) {
                                setState(() {});
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'),
                                ),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: isInCart
                    ? null
                    : () async {
                        // if (_isInCart) {
                        //   return;
                        // }
                        final User? user = firebaseAuth.currentUser;

                        if (user == null) {
                          GlobalActions.errorDialog(
                              subtitle: 'Inicie sesion', context: context);
                          return;
                        }
                        await GlobalActions.addToCart(
                            productId: productModel.id,
                            quantity: int.parse(_cantidadControlller.text),
                            context: context);
                        await cartProvider.fetchCart();
                      },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).cardColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                    )),
                child: TextWidget(
                  text: isInCart ? 'Agregado' : 'Agregar',
                  maxLines: 1,
                  color: color,
                  textSize: 18,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
