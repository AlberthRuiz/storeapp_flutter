import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/pages/empty_page.dart';
import 'package:storeapp_flutter/provider/wishlist_provider.dart';
import 'package:storeapp_flutter/utils/global_actions.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/back_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';
import 'package:storeapp_flutter/widgets/wishlist_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return wishlistItemsList.isEmpty
        ? const EmptyPage(
            title: 'Lista vacia',
            subtitle: 'Nave y encuentra productps',
            imagePath: 'assets/images/wishlist.png',
            buttonText: 'Agregar',
          )
        : Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: const BackWidget(),
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: TextWidget(
                  text: 'Lista Deseos (${wishlistItemsList.length})',
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
                            await wishlistProvider.clearOnlineWishlist();
                            wishlistProvider.clearLocalWishlist();
                          },
                          context: context);
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ),
                  ),
                ]),
            body: MasonryGridView.count(
              itemCount: wishlistItemsList.length,
              crossAxisCount: 2,
              // mainAxisSpacing: 16,
              // crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishlistItemsList[index],
                    child: const WishlistWidget());
              },
            ));
  }
}
