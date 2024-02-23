import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.pureWhite,
  appBarTheme: const AppBarTheme(
    color: AppColors.pureWhite,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.black,
  appBarTheme: const AppBarTheme(
    color: AppColors.pureWhite,
  ),
);
