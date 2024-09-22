// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

/// [OptionsCrop] : Configuration options for image cropping functionality.
class OptionsCrop {
  /// The style for cropping the image.
  /// Can be either `CropStyle.circle` or `CropStyle.rectangle`.
  ///
  /// Default = [CropStyle.circle]
  CropStyle? cropStyle = CropStyle.circle;

  /// The color of the toolbar in the image cropper.
  ///
  /// Default = [Colors.deepOrange].
  Color toolbarColorCrop = Colors.deepOrange;

  /// The color of the widgets in the toolbar (such as icons or text)
  /// in the image cropper.
  ///
  /// Default = [Colors.white].
  Color toolbarWidgetColorCrop = Colors.white;

  /// The initial aspect ratio to be applied when the cropper starts.
  /// Choose from a set of aspect ratio presets.
  ///
  /// Default = [CropAspectRatioPreset.original].
  CropAspectRatioPresetData initAspectRatioCrop =
      CropAspectRatioPreset.original;

  /// The presentation style of the cropper on the web.
  /// It can either be displayed as a dialog or a page (route).
  ///
  /// Default = [WebPresentStyle.dialog].
  WebPresentStyle webPresentStyle = WebPresentStyle.dialog;

  /// Constructor for [OptionsCrop] to initialize cropping configurations.
  ///
  /// - [cropStyle] : (optional) Defines the cropping style, default is [CropStyle.circle].
  /// - [toolbarColorCrop] : The color for the toolbar, default is [Colors.deepOrange].
  /// - [toolbarWidgetColorCrop] : The color for the widgets in the toolbar, default is [Colors.white].
  /// - [initAspectRatioCrop] : The aspect ratio preset, default is [CropAspectRatioPreset.original].
  /// - [webPresentStyle] : The web presentation style, default is [WebPresentStyle.dialog].
  OptionsCrop({
    this.cropStyle,
    required this.toolbarColorCrop,
    required this.toolbarWidgetColorCrop,
    required this.initAspectRatioCrop,
    required this.webPresentStyle,
  });
}
