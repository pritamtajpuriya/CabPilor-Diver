import 'package:flutter/material.dart';

// This functions are responsible to make UI responsive across all the mobile devices.

Size size = WidgetsBinding.instance.window.physicalSize /
    WidgetsBinding.instance.window.devicePixelRatio;

final double SCREEN_DEVICE_WIDTH = size.width;
final double SCREEN_DEVICE_HEIGHT = size.height;
final double STATUS_BAR = WidgetsBinding.instance.window.viewPadding.top;

get width {
  return size.width;
}

///This method is used to get device viewport height.
get height {
  num statusBar =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.top;
  num bottomBar = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
      .viewPadding
      .bottom;
  num screenHeight = size.height - statusBar - bottomBar;
  return screenHeight;
}

///This method is used to set padding/margin (for the left and Right side) & width of the screen or widget according to the Viewport width.
double getHorizontalSize(double px) {
  return ((px * width) / SCREEN_DEVICE_WIDTH);
}

///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
double getVerticalSize(double px) {
  return ((px * height) / (SCREEN_DEVICE_HEIGHT - STATUS_BAR));
}

///This method is used to set smallest px in image height and width
double getSize(double px) {
  var height = getVerticalSize(px);
  var width = getHorizontalSize(px);
  if (height < width) {
    return height.toInt().toDouble();
  } else {
    return width.toInt().toDouble();
  }
}

///This method is used to set text font size according to Viewport
double getFontSize(double px) {
  return getSize(px);
}

///This method is used to set padding responsively
EdgeInsetsGeometry getPadding({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
}) {
  return getMarginOrPadding(
    all: all,
    left: left,
    top: top,
    right: right,
    bottom: bottom,
  );
}

///This method is used to set margin responsively
EdgeInsetsGeometry getMargin({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
}) {
  return getMarginOrPadding(
    all: all,
    left: left,
    top: top,
    right: right,
    bottom: bottom,
  );
}

EdgeInsetsGeometry getMarginOrPadding({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
}) {
  if (all != null) {
    left = all;
    top = all;
    right = all;
    bottom = all;
  }
  return EdgeInsets.only(
    left: getHorizontalSize(
      left ?? 0,
    ),
    top: getVerticalSize(
      top ?? 0,
    ),
    right: getHorizontalSize(
      right ?? 0,
    ),
    bottom: getVerticalSize(
      bottom ?? 0,
    ),
  );
}

//getPadding Symetric

EdgeInsetsGeometry getPaddingSymetric({
  double? horizontal,
  double? vertical,
}) {
  return EdgeInsets.symmetric(
    horizontal: horizontal ?? 0,
    vertical: vertical ?? 0,
  );
}
