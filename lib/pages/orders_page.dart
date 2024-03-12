import 'package:flutter/material.dart';
import 'package:storeapp_flutter/pages/empty_page.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/back_widget.dart';
import 'package:storeapp_flutter/widgets/orders_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    bool _isEmpty = true;
    return _isEmpty == true
        ? const EmptyPage(
            title: 'No tienes una order aun..',
            subtitle: 'Realiza una orden ahora...',
            buttonText: 'Comprar ahora',
            imagePath: 'assets/images/empty.png',
          ) 
        : Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              elevation: 0,
              centerTitle: false,
              title: TextWidget(
                text: 'Your orders (2)',
                color: color,
                textSize: 24.0,
                isTitle: true,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.separated(
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: OrderWidget(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: color,
                  thickness: 1,
                );
              },
            ));
  }
}
