import 'package:flutter/material.dart';
import 'package:image_cropping/image_cropping.dart';

/// [OptionsCropWindMacLinux] : Configuration options for image cropping functionality on Windows, macOS, and Linux.
class OptionsCropWindMacLinux {
  /// Callback function to be called when the image cropping is done.
  final dynamic Function(dynamic) onImageDoneListener;

  /// Callback function to be called when the image cropping starts.
  final void Function()? onImageStartLoading;

  /// Callback function to be called when the image cropping ends.
  final void Function()? onImageEndLoading;

  /// The selected aspect ratio for cropping.
  CropAspectRatio? selectedImageRatio;

  /// Whether to show other aspect ratios.
  final bool visibleOtherAspectRatios;

  /// The width of the square border.
  final double squareBorderWidth;

  /// Custom aspect ratios to be used.
  final List<CropAspectRatio>? customAspectRatios;

  /// The color of the square circle.
  final Color squareCircleColor;

  /// The size of the square circle.
  final double squareCircleSize;

  /// The default text color.
  final Color defaultTextColor;

  /// The selected text color.
  final Color selectedTextColor;

  /// The color for white space.
  final Color colorForWhiteSpace;

  /// The encoding quality of the output image.
  final int encodingQuality;

  /// The path to the worker.
  final String? workerPath;

  /// Whether to constrain the crop area.
  final bool isConstrain;

  /// Whether to make the area outside the crop darker.
  final bool makeDarkerOutside;

  /// The edge insets for the image.
  final EdgeInsets? imageEdgeInsets;

  /// Whether to use the root navigator.
  final bool rootNavigator;

  /// The output format of the cropped image.
  OutputImageFormat outputImageFormat;

  /// The key for the widget.
  final Key? key;

  /// Constructor for [OptionsCropWindMacLinux] to initialize cropping configurations.
  OptionsCropWindMacLinux({
    required this.onImageDoneListener,
    this.onImageStartLoading,
    this.onImageEndLoading,
    this.selectedImageRatio,
    this.visibleOtherAspectRatios = true,
    this.squareBorderWidth = 2,
    this.customAspectRatios,
    this.squareCircleColor = Colors.orange,
    this.squareCircleSize = 30,
    this.defaultTextColor = Colors.black,
    this.selectedTextColor = Colors.orange,
    this.colorForWhiteSpace = Colors.white,
    this.encodingQuality = 100,
    this.workerPath,
    this.isConstrain = true,
    this.makeDarkerOutside = true,
    this.imageEdgeInsets = const EdgeInsets.all(10),
    this.rootNavigator = false,
    this.outputImageFormat = OutputImageFormat.jpg,
    this.key,
  });
}
