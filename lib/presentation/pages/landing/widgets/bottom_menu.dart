import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/app_text_styles.dart';

class BottomMenu extends StatelessWidget {
  final int? bottomMenuIndex;
  final ValueChanged<int>? onChanged;
  BottomMenu({this.bottomMenuIndex, this.onChanged});

  BottomNavigationBarItem getItem(
    IconData image,
    String title,
    int index,
    ThemeData theme,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(
        image,
        color: index == bottomMenuIndex
            ? theme.primaryColor
            : theme.primaryColorDark,
      ),
      label: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    List<BottomNavigationBarItem> items = [
      getItem(Icons.two_wheeler, 'Ride', 0, theme),
      getItem(Icons.rss_feed_rounded, 'Assigned', 1, theme),
      getItem(Icons.notifications, 'Notifications', 2, theme),
      getItem(Icons.menu, 'More', 3, theme),
    ];
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: bottomMenuIndex!,
          onTap: (value) {
            switch (value) {
              case 0:
                onChanged!(0);
                break;

              case 1:
                onChanged!(1);
                break;
              case 2:
                onChanged!(2);
                break;
              case 3:
                onChanged!(3);
                break;
              case 4:
                onChanged!(4);
                break;
            }
          },
          items: items,
          // gap between icon and label

          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle:
              AppTextStyle.h5TitleTextStyle().copyWith(color: Colors.indigo),
          unselectedLabelStyle: AppTextStyle.h5TitleTextStyle().copyWith(
            color: Colors.grey,
          ),
          unselectedIconTheme: const IconThemeData(size: 20),
          selectedIconTheme: const IconThemeData(size: 24),
        ),
      ),
    );
  }
}
