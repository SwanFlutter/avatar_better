// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:picker_image_cropper/picker_image_cropper.dart';

/// [OptionsCrop] : Configuration options for image cropping functionality.
class OptionsCrop {
  /// The cropper theme to be used.
  /// Can be CropperTheme.light, CropperTheme.dark, CropperTheme.blue, or a custom theme.
  ///
  /// Default = [CropperTheme.light]
  ///
  /// You can uses custom theme = [ CropperTheme() ]
  CropperTheme cropperTheme;

  /// Custom labels for the cropper interface.
  /// Allows customization of text displayed in the cropper UI.
  /// If null, default labels will be used.
  CropperLabels? labels;

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

  /// Constructor for [OptionsCrop] to initialize cropping configurations.
  ///
  /// - [cropperTheme] : The theme for the cropper UI, default is [CropperTheme.light].
  /// - [aspectRatio] : The aspect ratio to be applied when cropping, default is [CropAspectRatio.square()].
  /// - [overlayType] : The shape of the crop overlay, default is [CropOverlayType.circle].
  /// - [outputType] : The desired output format, default is [OutputType.both].
  /// - [showGrid] : Whether to show a grid inside the crop box, default is true.
  /// - [maxScale] : The maximum zoom scale allowed, default is 3.0.
  /// - [useDraggableCropper] : Enables a draggable crop box, default is true.
  /// - [maxImageSize] : The maximum dimension for image resizing, default is 1920.
  OptionsCrop({
    this.cropperTheme = CropperTheme.light,
    CropAspectRatio? aspectRatio,
    this.overlayType = CropOverlayType.circle,
    this.outputType = OutputType.both,
    this.showGrid = true,
    this.maxScale = 3.0,
    this.useDraggableCropper = true,
    this.maxImageSize = 1920,
    this.labels,
  }) : aspectRatio = aspectRatio ?? CropAspectRatio.square();
}
