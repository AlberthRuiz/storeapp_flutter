import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/pages/init_page.dart';
import 'package:storeapp_flutter/provider/cart_provider.dart';
import 'package:storeapp_flutter/provider/products_provider.dart';
import 'package:storeapp_flutter/provider/wishlist_provider.dart';

class FetchPage extends StatefulWidget {
  const FetchPage({Key? key}) : super(key: key);

  @override
  State<FetchPage> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchPage> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 5), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final wishlistProvider =
          Provider.of<WishlistProvider>(context, listen: false);
      // final orderProvider = Provider.of<OrdersProvider>(context, listen: false);
      final User? user = firebaseAuth.currentUser;
      if (user == null) {
        await productsProvider.fetchProducts();
        cartProvider.clearLocalCart();
        wishlistProvider.clearLocalWishlist();
      } else {
        await productsProvider.fetchProducts();
        await cartProvider.fetchCart();
        await wishlistProvider.fetchWishlist();
      }
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => IntiPage(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/google.png",
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
