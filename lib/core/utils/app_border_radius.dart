import 'package:flutter/material.dart' show BorderRadius, Radius;

import 'app_sizes.dart';

final class AppBorderRadius {
  AppBorderRadius._();
  static const BorderRadius borderAll4 = BorderRadius.all(
    Radius.circular(
      Sizes.s4,
    ),
  );
  static const BorderRadius borderAll8 = BorderRadius.all(
    Radius.circular(
      Sizes.s8,
    ),
  );
  static const BorderRadius borderAll10 = BorderRadius.all(
    Radius.circular(
      Sizes.s10,
    ),
  );
  static const BorderRadius borderAll12 = BorderRadius.all(
    Radius.circular(
      Sizes.s12,
    ),
  );
  static const BorderRadius borderAll16 = BorderRadius.all(
    Radius.circular(
      Sizes.s16,
    ),
  );
  static const BorderRadius borderAll20 = BorderRadius.all(
    Radius.circular(
      Sizes.s20,
    ),
  );
  static const BorderRadius borderAll24 = BorderRadius.all(
    Radius.circular(
      Sizes.s24,
    ),
  );
  static const BorderRadius borderAll32 = BorderRadius.all(
    Radius.circular(
      Sizes.s32,
    ),
  );
  static const BorderRadius borderAll48 = BorderRadius.all(
    Radius.circular(
      Sizes.s48,
    ),
  );
  static const BorderRadius borderTopLeftRight32 = BorderRadius.only(
    topLeft: Radius.circular(
      Sizes.s32,
    ),
    topRight: Radius.circular(
      Sizes.s32,
    ),
  );
}
