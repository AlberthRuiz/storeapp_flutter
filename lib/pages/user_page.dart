import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/pages/forget_password_page.dart';
import 'package:storeapp_flutter/pages/login_page.dart';
import 'package:storeapp_flutter/pages/orders_page.dart';
import 'package:storeapp_flutter/pages/viewed_recently_page.dart';
import 'package:storeapp_flutter/pages/wishlist_page.dart';
import 'package:storeapp_flutter/provider/dark_theme_provider.dart';
import 'package:storeapp_flutter/utils/global_actions.dart';
import 'package:storeapp_flutter/utils/loading_manager.dart';
import 'package:storeapp_flutter/utils/utils.dart';
import 'package:storeapp_flutter/widgets/user_list_tile_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  String? _email;
  String? _name;
  String? address;
  bool _isLoading = false;
  final User? user = firebaseAuth.currentUser;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;

      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      _email = userDoc.get('email');
      _name = userDoc.get('nombre');
      address = userDoc.get('direccion-envio');
      _addressTextController.text = userDoc.get('direccion-envio');
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalActions.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        body: LoadingManager(
      isLoading: _isLoading,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Utils(context).getScreenSize.height * 0.10,
              ),
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
                          text: _name == null ? 'Invitado' : _name,
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
                  _email == null ? '-' : _email!,
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
                subtitulo: address,
                leadingIcon: themeState.getDarkTheme
                    ? Icon(
                        IconlyBold.location,
                        color: color,
                      )
                    : Icon(IconlyLight.location, color: color),
                trailingIcon: themeState.getDarkTheme
                    ? Icon(IconlyBold.arrow_right, color: color)
                    : Icon(IconlyLight.arrow_right, color: color),
                function: () {
                  _showAddressDialog();
                },
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
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewedRecentlyPage(),
                      ));
                },
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
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgetPasswordPage(),
                      ));
                },
              ),
              UserListTileWidget(
                titulo: user == null ? 'Iniciar Sesion' : 'Salir',
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
                  if (user == null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                    return;
                  }
                  GlobalActions.showLogout(context: context);
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Direccion'),
            content: TextField(
              controller: _addressTextController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: "Direccion"),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (_addressTextController.text.isEmpty) {
                    Navigator.pop(context);
                    return;
                  }
                  if (user == null) {
                    Navigator.pop(context);
                  } else {
                    String _uid = user!.uid;
                    try {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(_uid)
                          .update({
                        'direccion-envio': _addressTextController.text,
                      });

                      Navigator.pop(context);
                      setState(() {
                        address = _addressTextController.text;
                      });
                    } catch (err) {
                      GlobalActions.errorDialog(
                          subtitle: err.toString(), context: context);
                    }
                  }
                  _addressTextController.clear();
                },
                child: const Text('Actualizar'),
              ),
            ],
          );
        });
  }
}
