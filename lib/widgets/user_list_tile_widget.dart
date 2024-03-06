import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp_flutter/provider/dark_theme_provider.dart';

// ignore: must_be_immutable
class UserListTileWidget extends StatelessWidget {
  String titulo;
  String? subtitulo;
  Icon leadingIcon;
  Icon trailingIcon;
  Function? function;

  UserListTileWidget(
      {required this.titulo,
      required this.leadingIcon,
      required this.trailingIcon,
      this.subtitulo,
      this.function});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return ListTile(
      title: Text(titulo, style: TextStyle(fontSize: 18, color: color)),
      subtitle: Text(
        subtitulo ?? "",
        style: TextStyle(fontSize: 12, color: color),
      ),
      leading: leadingIcon,
      trailing: trailingIcon,
      onTap: () {
        function!();
      },
    );
  }
}
