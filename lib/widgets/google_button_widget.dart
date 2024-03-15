import 'package:flutter/material.dart';
import 'package:storeapp_flutter/services/auth_services.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final util = Utils(context);
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.blueAccent,
      child: InkWell(
        onTap: () {
          AuthService().signInWithGoogle(context);
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(right: util.getScreenSize.width * 0.15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                'assets/images/google.png',
                width: 40.0,
              ),
            ),
          ),
          TextWidget(
            text: 'Iniciar Sesion',
            color: Colors.white,
            textSize: 20,
            isTitle: true,
          )
        ]),
      ),
    );
  }
}
