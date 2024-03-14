import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/models/products_model.dart';
import 'package:storeapp_flutter/pages/product_details_page.dart';
import 'package:storeapp_flutter/provider/cart_provider.dart';
import 'package:storeapp_flutter/provider/wishlist_provider.dart';
import 'package:storeapp_flutter/utils/global_actions.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/heart_button_widget.dart';
import 'package:storeapp_flutter/widgets/price_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class OnSaleWidget extends StatefulWidget {
  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final productModel = Provider.of<ProductModel>(context);
    Size size = Utils(context).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(id: productModel.id),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FancyShimmerImage(
                        imageUrl: productModel.imageUrl,
                        height: size.width * 0.22,
                        width: size.width * 0.22,
                        boxFit: BoxFit.fill,
                      ),
                      Column(
                        children: [
                          TextWidget(
                            text: productModel.isUnd ? '1Piece' : '1KG',
                            color: color,
                            textSize: 22,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: isInCart
                                    ? null
                                    : () async {
                                        final User? user =
                                            firebaseAuth.currentUser;

                                        if (user == null) {
                                          GlobalActions.errorDialog(
                                              subtitle:
                                                  'No user found, Please login first',
                                              context: context);
                                          return;
                                        }
                                        await GlobalActions.addToCart(
                                            productId: productModel.id,
                                            quantity: 1,
                                            context: context);
                                        await cartProvider.fetchCart();
                                        // cartProvider.addProductsToCart(
                                        //     productId: productModel.id,
                                        //     quantity: 1);
                                      },
                                child: Icon(
                                  isInCart ? IconlyBold.buy : IconlyLight.buy,
                                  size: 22,
                                  color: isInCart ? Colors.green : color,
                                ),
                              ),
                              HeartButtonWidget(
                                productId: productModel.id,
                                isInWishlist: isInWishlist,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  PriceWidget(
                    salePrice: productModel.salePrice,
                    price: productModel.price,
                    textPrice: '1',
                    isOnSale: true,
                  ),
                  const SizedBox(height: 5),
                  TextWidget(
                    text: productModel.title,
                    color: color,
                    textSize: 16,
                    isTitle: true,
                  ),
                  const SizedBox(height: 5),
                ]),
          ),
        ),
      ),
    );
  }
}
