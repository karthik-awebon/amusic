import 'package:flutter/material.dart';

class JhankarAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget title;
  AppBar appBar;
  List<Widget> widgets;
  TabBar? bottom;
  JhankarAppBar(
      {Key? key,
      required this.title,
      required this.appBar,
      required this.widgets,
      this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: Color.fromARGB(255, 52, 89, 131),
      centerTitle: true,
      actions: widgets,
        bottom: bottom
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
