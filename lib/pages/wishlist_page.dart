import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
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
    final util = Utils(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Theme.of(context).scaffoldBackgroundColor,
          leading: const BackWidget(),
          automaticallyImplyLeading: false,
          title: TextWidget(
            text: "Deaseados",
            color: util.color,
            textSize: 24,
            isTitle: true,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  GlobalActions.warningDialog(
                      title: "ELiminar deseados?",
                      subtitle: "Estas seguro?",
                      fct: () {},
                      context: context);
                },
                icon: Icon(IconlyBroken.delete))
          ],
        ),
        body: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            return const WishlistWidget();
          },
        ));
  }
}
