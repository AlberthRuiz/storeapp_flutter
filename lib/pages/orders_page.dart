import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/pages/empty_page.dart';
import 'package:storeapp_flutter/provider/orders_provider.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/back_widget.dart';
import 'package:storeapp_flutter/widgets/orders_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final ordersList = ordersProvider.getOrders;

    return FutureBuilder(
      future: ordersProvider.fetchOrders(),
      builder: (context, snapshot) {
        return ordersList.isEmpty
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
                    text: 'Pedidos (${ordersList.length})',
                    color: color,
                    textSize: 24.0,
                    isTitle: true,
                  ),
                  backgroundColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.9),
                ),
                body: ListView.separated(
                  itemCount: ordersList.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 6),
                      child: ChangeNotifierProvider.value(
                        value: ordersList[index],
                        child: const OrderWidget(),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: color,
                      thickness: 1,
                    );
                  },
                ));
      },
    );
  }
}
