import 'package:flutter/material.dart';

import '../core/utils/colors.dart';
import '../core/utils/size_utils.dart';

class AppDecoration {
  static BoxDecoration get outlineBlack9001e => BoxDecoration(
        color: AppColors.whiteA700,
        boxShadow: [
          BoxShadow(
            color: AppColors.black9001e,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              2,
            ),
          ),
        ],
      );

  //normal
  static BoxDecoration get outlineLite => BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      );

  static BoxDecoration get outlineBlack9001e2 => BoxDecoration(
        color: AppColors.whiteA700,
        boxShadow: [
          BoxShadow(
            color: AppColors.black9001e,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      );

  static BoxDecoration get txtOutlineTeal400 => BoxDecoration(
        color: AppColors.teal40033,
        border: Border.all(
          color: AppColors.teal400,
          width: getHorizontalSize(
            3,
          ),
        ),
      );

  static BoxDecoration get outlineTeal400 => BoxDecoration(
        color: AppColors.teal40019,
        border: Border.all(
          color: AppColors.teal400,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder8 = BorderRadius.circular(
    getHorizontalSize(
      8,
    ),
  );
  static BorderRadius txtCircleBorder30 = BorderRadius.circular(
    getHorizontalSize(
      30,
    ),
  );
  static BorderRadius roundedBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12,
    ),
  );
}
