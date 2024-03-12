import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:storeapp_flutter/pages/empty_page.dart';
import 'package:storeapp_flutter/utils/global_actions.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/cart_widget.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final util = Utils(context);
    bool _isEmpty = false;
    return _isEmpty
        // ignore: dead_code
        ? const EmptyPage(
            title: 'Carrito esta vacio',
            subtitle: 'Añadir algun producto...',
            buttonText: 'Comprar Ahora',
            imagePath: 'assets/images/empty-cart.png',
          // ignore: dead_code
          ): Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: "Mi Carrito (2)",
            color: util.color,
            textSize: 24,
            isTitle: true,
          ),
          actions: [
            IconButton(
              onPressed: () {
                GlobalActions.warningDialog(
                    title: "ELiminar carrito?",
                    subtitle: "Quieres eliminar el carro de compras?",
                    fct: () {},
                    context: context);
              },
              icon: Icon(IconlyBroken.delete),
            )
          ],
        ),
        body:
        
         Column(
          children: [
            _comprar(context: context),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CartWidget();
                },
              ),
            ),
          ],
        ));
  }

  Widget _comprar({required BuildContext context}) {
    final util = Utils(context);
    return SizedBox(
      width: util.getScreenSize.width,
      height: util.getScreenSize.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: "Comprar",
                    color: Colors.white,
                    textSize: 20,
                  ),
                ),
              ),
            ),
            FittedBox(
                child: TextWidget(
              text: "Total: S/. 2",
              color: util.color,
              textSize: 18,
              isTitle: true,
            )),
          ],
        ),
      ),
    );
  }
}
