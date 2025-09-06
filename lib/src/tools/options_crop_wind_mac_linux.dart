import 'package:flutter/material.dart';
import 'package:picker_image_cropper/picker_image_cropper.dart';

/// [OptionsCropWindMacLinux] : Configuration options for image cropping functionality on Windows, macOS, and Linux.
/// This class is kept for backward compatibility but now uses the unified picker_image_cropper package.
class OptionsCropWindMacLinux {
  /// The cropper theme to be used.
  /// Can be CropperTheme.light, CropperTheme.dark, CropperTheme.blue, or a custom theme.
  ///
  /// Default = [CropperTheme.light]
  CropperTheme cropperTheme;

  /// The aspect ratio to be applied when cropping.
  /// Can be CropAspectRatio.free(), CropAspectRatio.square(), etc.
  ///
  /// Default = [CropAspectRatio.square()]
  CropAspectRatio aspectRatio;

  /// The overlay type for the crop area.
  /// Can be CropOverlayType.rectangle or CropOverlayType.circle.
  ///
  /// Default = [CropOverlayType.circle]
  CropOverlayType overlayType;

  /// The output type for the cropped image.
  /// Can be OutputType.bytes, OutputType.file, or OutputType.both.
  ///
  /// Default = [OutputType.both]
  OutputType outputType;

  /// Whether to show a grid inside the crop box.
  ///
  /// Default = true
  bool showGrid;

  /// The maximum zoom scale allowed.
  ///
  /// Default = 3.0
  double maxScale;

  /// Enables a draggable crop box.
  ///
  /// Default = true
  bool useDraggableCropper;

  /// The maximum dimension (width or height) to which large images are resized
  /// before cropping to improve performance.
  ///
  /// Default = 1920
  int maxImageSize;

  // Legacy properties kept for backward compatibility (not used in new implementation)
  final dynamic Function(dynamic)? onImageDoneListener;
  final void Function()? onImageStartLoading;
  final void Function()? onImageEndLoading;
  final dynamic selectedImageRatio;
  final bool visibleOtherAspectRatios;
  final double squareBorderWidth;
  final List<dynamic>? customAspectRatios;
  final Color squareCircleColor;
  final double squareCircleSize;
  final Color defaultTextColor;
  final Color selectedTextColor;
  final Color colorForWhiteSpace;
  final int encodingQuality;
  final String? workerPath;
  final bool isConstrain;
  final bool makeDarkerOutside;
  final EdgeInsets? imageEdgeInsets;
  final bool rootNavigator;
  final dynamic outputImageFormat;
  final Key? key;

  /// Constructor for [OptionsCropWindMacLinux] to initialize cropping configurations.
  OptionsCropWindMacLinux({
    this.cropperTheme = CropperTheme.light,
    CropAspectRatio? aspectRatio,
    this.overlayType = CropOverlayType.circle,
    this.outputType = OutputType.both,
    this.showGrid = true,
    this.maxScale = 3.0,
    this.useDraggableCropper = true,
    this.maxImageSize = 1920,
    // Legacy parameters for backward compatibility
    this.onImageDoneListener,
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
    this.outputImageFormat,
    this.key,
  }) : aspectRatio = aspectRatio ?? CropAspectRatio.square();
}
