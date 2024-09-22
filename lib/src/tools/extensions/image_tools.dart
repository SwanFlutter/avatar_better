import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageTools {
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  ImageTools({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  bool multiple = false;
  Future<List<XFile>> pickImage(ImageSource imageSource, bool multiple) async {
    if (multiple == true) {
      return await _imagePicker.pickMultiImage();
    } else {
      final file = await _imagePicker.pickImage(source: imageSource);
      if (file != null) {
        return [file];
      }
      return [];
    }
  }

  Future<CroppedFile?> crop(XFile file,
      {CropStyle? cropStyle,
      Color? toolbarColor,
      Color? toolbarWidgetColor,
      CropAspectRatioPresetData? initAspectRatio}) async {
    try {
      return await _imageCropper.cropImage(
        sourcePath: file.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: toolbarColor!,
            toolbarWidgetColor: toolbarWidgetColor!,
            initAspectRatio: initAspectRatio!,
            cropStyle: cropStyle!,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
        ],
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Crop Error: $e');
      }
      return null;
    }
  }

  Future<Uint8List?> cropForWeb(XFile file,
      {WebPresentStyle? presentStyle,
      required BuildContext buildContext}) async {
    try {
      if (kIsWeb) {
        // For web platform
        final uiSettingsList = [
          WebUiSettings(
            context: buildContext,
            presentStyle: presentStyle!,
          )
        ];
        final croppedFile = await _imageCropper.cropImage(
          sourcePath: file.path,
          uiSettings: uiSettingsList,
        );
        if (croppedFile != null) {
          return croppedFile.readAsBytes();
        }
      }
    } catch (e) {
      debugPrint('Crop Error (Web): $e');
    }
    return null;
  }
}
