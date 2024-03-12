import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/pages/orders_page.dart';
import 'package:storeapp_flutter/pages/wishlist_page.dart';
import 'package:storeapp_flutter/provider/dark_theme_provider.dart';
import 'package:storeapp_flutter/utils/global_actions.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/user_list_tile_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Utils(context).getScreenSize.height *0.10,),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 60,
                  width: 60,
                  child: themeState.getDarkTheme
                      ? Icon(
                          IconlyBold.profile,
                          color: color,
                        )
                      : Icon(IconlyLight.profile, color: color),
                ),
                title: RichText(
                  text: TextSpan(
                    text: "Hola ",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Usuario",
                          style: TextStyle(
                            color: color,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Usuario es presionado");
                            }),
                    ],
                  ),
                ),
                subtitle: Text(
                  "mail@gmail.com",
                  style: TextStyle(color: color),
                ),
              ),
           
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              SwitchListTile(
                title: Text(
                  'Tema',
                  style: themeState.getDarkTheme
                      ? TextStyle(color: Colors.white)
                      : TextStyle(color: Colors.black),
                ),
                secondary: Icon(
                    themeState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    color: color),
                onChanged: (bool value) {
                  setState(() {
                    themeState.setDarkTheme = value;
                  });
                },
                value: themeState.getDarkTheme,
              ),
              UserListTileWidget(
                titulo: "Direccion",
                subtitulo: "Detalle",
                leadingIcon: themeState.getDarkTheme
                    ? Icon(
                        IconlyBold.location,
                        color: color,
                      )
                    : Icon(IconlyLight.location, color: color),
                trailingIcon: themeState.getDarkTheme
                    ? Icon(IconlyBold.arrow_right, color: color)
                    : Icon(IconlyLight.arrow_right, color: color),
              ),
              UserListTileWidget(
                titulo: "Lista Deseos",
                leadingIcon: themeState.getDarkTheme
                    ? Icon(
                        IconlyBold.heart,
                        color: color,
                      )
                    : Icon(IconlyLight.heart, color: color),
                trailingIcon: themeState.getDarkTheme
                    ? Icon(IconlyBold.arrow_right, color: color)
                    : Icon(IconlyLight.arrow_right, color: color),
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlistPage(),
                      ));
                },
              ),
              UserListTileWidget(
                titulo: "Pedidos",
                leadingIcon: themeState.getDarkTheme
                    ? Icon(
                        IconlyBold.bag,
                        color: color,
                      )
                    : Icon(IconlyLight.bag, color: color),
                trailingIcon: themeState.getDarkTheme
                    ? Icon(IconlyBold.arrow_right, color: color)
                    : Icon(IconlyLight.arrow_right, color: color),
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdersPage(),
                      ));
                },
              ),
              UserListTileWidget(
                titulo: "Vistos",
                leadingIcon: themeState.getDarkTheme
                    ? Icon(
                        IconlyBold.show,
                        color: color,
                      )
                    : Icon(IconlyLight.show, color: color),
                trailingIcon: themeState.getDarkTheme
                    ? Icon(IconlyBold.arrow_right, color: color)
                    : Icon(IconlyLight.arrow_right, color: color),
              ),
              UserListTileWidget(
                titulo: "Olvide Contraseña",
                subtitulo: "Recuperar contraseña de manera simple",
                leadingIcon: themeState.getDarkTheme
                    ? Icon(
                        IconlyBold.unlock,
                        color: color,
                      )
                    : Icon(IconlyLight.unlock, color: color),
                trailingIcon: themeState.getDarkTheme
                    ? Icon(IconlyBold.arrow_right, color: color)
                    : Icon(IconlyLight.arrow_right, color: color),
              ),
              UserListTileWidget(
                titulo: "Salir",
                leadingIcon: themeState.getDarkTheme
                    ? Icon(
                        IconlyBold.logout,
                        color: color,
                      )
                    : Icon(IconlyLight.logout, color: color),
                trailingIcon: themeState.getDarkTheme
                    ? Icon(IconlyBold.arrow_right, color: color)
                    : Icon(IconlyLight.arrow_right, color: color),
                function: () {
                  GlobalActions.showLogout(context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
