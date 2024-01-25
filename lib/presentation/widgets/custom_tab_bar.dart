import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends Container implements PreferredSizeWidget {
  CustomTabBar(
      {super.key,
      required this.colorcode,
      required this.tabBar,
      required this.tabTitle1,
      required this.tabTitle2});

  final Color colorcode;
  final TabController tabBar;
  final String tabTitle1;
  final String tabTitle2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: colorcode,
          border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey.shade300))),
      child: TabBar(
          controller: tabBar,
          indicator: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 2.0, color: Colors.indigo))),
          labelColor: Colors.indigo,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                tabTitle1,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                tabTitle2,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            )
          ]),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
