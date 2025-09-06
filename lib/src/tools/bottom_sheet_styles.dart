import 'package:avatar_better/src/tools/gallery_buttom.dart';
import 'package:flutter/material.dart';

/// [BottomSheetStyles] : Configuration for customizing the bottom sheet's appearance and behavior.
///
/// - [backgroundColor]: The background color of the bottom sheet.
///   Default = `Colors.white`.
/// - [shape]: The shape of the bottom sheet.
///   It can be used to set a custom shape like a rounded corner.
/// - [elevation]: The elevation (shadow) of the bottom sheet.
///   Default = `4.0`.
/// - [galleryButton]: Configuration for the gallery button displayed inside the bottom sheet.
/// - [cameraButton]: Configuration for the camera button displayed inside the bottom sheet.
/// - [middleText]: Text displayed between the camera and gallery buttons.
///   Default = "OR".
/// - [middleTextStyle]: The text style for the middle text.
///   Default = `TextStyle()`.
class BottomSheetStyles {
  Color? backgroundColor = Colors.white;
  final ShapeBorder? shape;
  double? elevation = 4.0;
  final GalleryBottom? galleryButton;
  final CameraButton? cameraButton;
  String? middleText = "OR";
  TextStyle? middleTextStyle = const TextStyle();

  BottomSheetStyles({
    required this.backgroundColor,
    this.shape,
    this.galleryButton,
    this.cameraButton,
    required this.elevation,
    required this.middleText,
    required this.middleTextStyle,
  });
}
