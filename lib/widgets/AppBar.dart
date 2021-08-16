import 'package:flutter/material.dart';

class AppBarDetails extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const AppBarDetails({Key key, @required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.00);

  @override
  _AppBarDetailsState createState() => _AppBarDetailsState();
}

class _AppBarDetailsState extends State<AppBarDetails> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(widget.title),
    );
  }
}
