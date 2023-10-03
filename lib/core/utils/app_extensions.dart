import 'package:flutter/material.dart'
    show BuildContext, MediaQuery, Orientation;
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension DeviceInfo on BuildContext {
  bool get isPortrait => MediaQuery.orientationOf(this) == Orientation.portrait;
  double get screenH => MediaQuery.sizeOf(this).height;
  double get screenW => MediaQuery.sizeOf(this).width;
  //bool get isKeyboardVisible => MediaQuery.paddingOf(this).bottom != 0.0;
  bool get isKeyboardVisible => MediaQuery.viewInsetsOf(this).bottom != 0.0;
  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;
  double get statusBarHeight => MediaQuery.viewInsetsOf(this).top;
  double get topPadding => MediaQuery.paddingOf(this).top;
}

extension ScreenUtilsHelper on num {
  ///[ScreenUtil.setWidth]
  double get w => ScreenUtil().setWidth(this);

  ///[ScreenUtil.setHeight]
  double get h => ScreenUtil().setHeight(this);

  ///[ScreenUtil.radius]
  double get r => ScreenUtil().radius(this);

  ///[ScreenUtil.setSp]
  double get sp => ScreenUtil().setSp(this);

  ///Multiple of screen width
  double get sw => ScreenUtil().screenWidth * this;

  ///Multiple of screen height
  double get sh => ScreenUtil().screenHeight * this;
}

// extension TextStylesCopyWith on TextStyle {
//   TextStyle get bold => copyWith(
//         fontWeight: FontWeight.bold,
//       );
//   TextStyle get withPrimaryColor => copyWith(
//         color: AppColors.primary,
//       );
//   TextStyle copyColorWith(Color color) => copyWith(
//         color: color,
//       );
// }
