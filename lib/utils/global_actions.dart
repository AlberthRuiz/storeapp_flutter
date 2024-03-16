import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:storeapp_flutter/consts/constants.dart';
import 'package:storeapp_flutter/pages/login_page.dart';
import 'package:storeapp_flutter/widgets/text_widget.dart';
import 'package:uuid/uuid.dart';

class GlobalActions {
  static Future<void> showLogout({required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  "assets/images/logout.png",
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text("Logout"),
              ],
            ),
            content: const Text(
              "Esta seguro que deseas cerrar sesion?",
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.blueAccent,
                  text: "Cancelar",
                  textSize: 16,
                ),
              ),
              TextButton(
                onPressed: () async {
                  await firebaseAuth.signOut();
                  await GoogleSignIn().signOut();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: TextWidget(
                  color: Colors.redAccent,
                  text: "OK",
                  textSize: 16,
                ),
              ),
            ],
          );
        });
  }

  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(title),
            ]),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'Cancel',
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {
                  fct();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.red,
                  text: 'OK',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text('Ocurrio un error'),
            ]),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'Ok',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }

  static Future<void> addToCart(
      {required String idproducto,
      required int cantidad,
      required BuildContext context}) async {
    final User? user = firebaseAuth.currentUser;
    final uid = user!.uid;
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('usuarios').doc(uid).update({
        'carrito': FieldValue.arrayUnion([
          {
            'idCarrito': cartId,
            'idproducto': idproducto,
            "cantidad": cantidad,
          }
        ])
      });
      
      await Fluttertoast.showToast(
        msg: "Producto agregado al carrito",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        

      );
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }

  static Future<void> addToWishlist(
      {required String idproducto, required BuildContext context}) async {
    final User? user = firebaseAuth.currentUser;
    final uid = user!.uid;
    final listaId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('usuarios').doc(uid).update({
        'lista': FieldValue.arrayUnion([
          {
            'listaId': listaId,
            'idproducto': idproducto,
          }
        ])
      });
      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.greenAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        behavior: SnackBarBehavior.floating,
        content: Text("Item agregado"),
      ));
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }
}
