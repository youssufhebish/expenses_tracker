import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/colors.dart';

const AppBarTheme appBarTheme = AppBarTheme(
  elevation: 0.0,
  centerTitle: true,
  backgroundColor: AppColors.lightBackground,
  foregroundColor: AppColors.lightTextPrimary,
  iconTheme: IconThemeData(color: AppColors.lightTextPrimary, size: 24.0),
  titleTextStyle: TextStyle(
    color: AppColors.lightTextPrimary,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  ),
  systemOverlayStyle: SystemUiOverlayStyle.dark,
);

const AppBarTheme darkAppBarTheme = AppBarTheme(
  elevation: 0.0,
  centerTitle: true,
  backgroundColor: AppColors.darkBackground,
  foregroundColor: AppColors.darkTextPrimary,
  iconTheme: IconThemeData(color: AppColors.darkTextPrimary, size: 24.0),
  titleTextStyle: TextStyle(
    color: AppColors.darkTextPrimary,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  ),
  systemOverlayStyle: SystemUiOverlayStyle.light,
);
