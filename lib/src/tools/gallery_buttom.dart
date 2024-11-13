import 'package:flutter/material.dart';

/// [GalleryBottom] : Configuration for the gallery button in the bottom sheet.
///
/// - [text]: The text label displayed on the gallery button.
///   Default = "Browse Gallery".
/// - [style]: The text style for the button label.
///   Default = `TextStyle()`.
/// - [color]: The background color of the gallery button.
///   Default = `Colors.grey.shade100`.
/// - [icon]: The icon displayed next to the text on the gallery button.
///   Default = `Icons.image_outlined`.
class GalleryBottom {
  String text = "Browse Gallery";
  TextStyle? style = const TextStyle();
  Color color = Colors.grey.shade100;
  Icon? icon = const Icon(Icons.image_outlined);

  GalleryBottom({
    required this.style,
    required this.color,
    required this.text,
    required this.icon,
  });
}

/// [CameraButton] : Configuration for the camera button in the bottom sheet.
///
/// - [text]: The text label displayed on the camera button.
///   Default = "Use camera".
/// - [style]: The text style for the button label.
///   Default = `TextStyle()`.
/// - [color]: The background color of the camera button.
///   Default = `Colors.grey.shade100`.
/// - [icon]: The icon displayed next to the text on the camera button.
///   Default = `Icons.camera_alt_outlined`.
class CameraButton {
  String text = "Use camera";
  TextStyle? style = const TextStyle();
  Color color = Colors.grey.shade100;
  Icon? icon = const Icon(Icons.camera_alt_outlined);

  CameraButton({
    required this.style,
    required this.color,
    required this.text,
    required this.icon,
  });
}
