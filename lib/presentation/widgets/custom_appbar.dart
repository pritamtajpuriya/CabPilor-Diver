import 'package:flutter/material.dart';

import '../../config/app_styles.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/size_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    required this.height,
    this.leadingWidth,
    this.leadingIconData,
    this.leadingIconPress,
    this.iconData1,
    this.iconData1Press,
    this.title,
    this.centerTitle,
    this.actions,
    this.isBackButton = true,
  }) : super(key: key);

  final double height;
  final double? leadingWidth;
  final IconData? leadingIconData;
  final Function? leadingIconPress;
  final IconData? iconData1;
  final VoidCallback? iconData1Press;
  final String? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final bool isBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      leadingWidth: leadingWidth ?? 0,
      leading: isBackButton == true
          ? IconButton(
              padding: getPadding(left: 22),
              onPressed: leadingIconPress as void Function()? ??
                  () {
                    Navigator.pop(context);
                  },
              icon: Icon(
                leadingIconData ?? Icons.arrow_back,
                size: getSize(28),
                color: AppColors.teal400,
              ),
            )
          : SizedBox.shrink(),
      title: Text(
        title ?? "",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: AppStyle.txtInterSemiBold16.copyWith(
          color: AppColors.black900,
        ),
      ),
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions ??
          [
            InkWell(
              onTap: iconData1Press ?? null,
              child: Padding(
                padding: getMargin(left: 22, right: 22),
                child: Icon(
                  iconData1 ?? Icons.info_outlined,
                  size: getSize(28),
                  color: AppColors.teal400,
                ),
              ),
            ),
          ],
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.teal400,
    );
  }

  @override
  Size get preferredSize => Size(
        double.infinity,
        height,
      );
}
