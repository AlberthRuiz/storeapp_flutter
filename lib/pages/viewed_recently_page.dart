import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/pages/empty_page.dart';
import 'package:storeapp_flutter/provider/viewed_prod_provider.dart';
import 'package:storeapp_flutter/utils/global_actions.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/back_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';
import 'package:storeapp_flutter/widgets/viewed_widget.dart';

class ViewedRecentlyPage extends StatefulWidget {
  const ViewedRecentlyPage({super.key});

  @override
  State<ViewedRecentlyPage> createState() => _ViewedRecentlyPageState();
}

class _ViewedRecentlyPageState extends State<ViewedRecentlyPage> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;

    // Size size = Utils(context).getScreenSize;
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    final viewedProdItemsList = viewedProdProvider.getViewedProdlistItems.values
        .toList()
        .reversed
        .toList();
    if (viewedProdItemsList.isEmpty) {
      return const EmptyPage(
        title: 'Historial',
        subtitle: 'No tienes productos vistos!',
        buttonText: 'Comprar',
        imagePath: 'assets/images/empty.png',
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                GlobalActions.warningDialog(
                    title: 'Eliminar?',
                    subtitle: 'Estas Seguro?',
                    fct: () {
                      viewedProdProvider.clearHistory();
                    },
                    context: context);
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            )
          ],
          leading: const BackWidget(),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: TextWidget(
            text: 'History',
            color: color,
            textSize: 24.0,
          ),
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        body: ListView.builder(
            itemCount: viewedProdItemsList.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: ChangeNotifierProvider.value(
                    value: viewedProdItemsList[index],
                    child: const ViewedWidget()),
              );
            }),
      );
    }
  }
}
