import 'package:flutter/material.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';

class AppelButton extends StatelessWidget {
  const AppelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white.withOpacity(0.5),
      child: InkWell(
        onTap: () {
          //AuthService().signInWithApple();
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                'assets/images/apple.png',
                width: 40.0,
              ),
            ),
          ),
          TextWidget(
            text: 'Iniciar con Apple',
            color: Colors.white,
            textSize: 18,
            isTitle: true,
          )
        ]),
      ),
    );
  }
}
