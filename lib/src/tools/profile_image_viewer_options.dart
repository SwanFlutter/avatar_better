// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class ProfileImageViewerOptions {
  /// [stylePageViewTextName ]:the style of the PageView text appbar.
  TextStyle? stylePageViewTextName = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 22.0,
  );

  /// [backgroundColorPageViewAppBar]: the background color of the PageView text appbar.
  Color? backgroundColorPageViewAppBar = Colors.white;

  /// [widgetLoadingPageView]:is an optional widget that is displayed while the PageView is loading.
  final Widget? widgetLoadingPageView;

  /// [backgroundColorDropdownMenuItem ]:is an optional parameter that specifies the background color of the dropdown menu item.
  Color? backgroundColorDropdownMenuItem = Colors.white;

  /// [iconColorDropdownMenuItem ]:is an optional parameter that specifies the icon color of the dropdown menu item.
  Color? iconColorDropdownMenuItem = Colors.black;

  /// [backBottomColorPageView]:is an optional parameter that specifies the  color of the bottom of the dropdown menu.
  Color? backBottomColorPageView = Colors.black;

  /// Represents the fit of the background image.
  BoxFit? fitBackgroundImage = BoxFit.fitHeight;

  ProfileImageViewerOptions({
    this.stylePageViewTextName,
    this.backgroundColorPageViewAppBar,
    this.widgetLoadingPageView,
    this.backgroundColorDropdownMenuItem,
    this.iconColorDropdownMenuItem,
    this.backBottomColorPageView,
    this.fitBackgroundImage,
  });
}
