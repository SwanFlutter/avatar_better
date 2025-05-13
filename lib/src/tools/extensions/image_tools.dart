import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_master/permission_master.dart';

class ImageTools {
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;
  final PermissionMaster? _permissionMaster;

  ImageTools({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper(),
        // Only initialize PermissionMaster for Android and iOS
        _permissionMaster =
            (Platform.isAndroid || Platform.isIOS) ? PermissionMaster() : null;

  bool multiple = false;

  // Get Android SDK version
  int? _androidSdkVersion;
  Future<int> getAndroidSdkVersion() async {
    if (_androidSdkVersion != null) return _androidSdkVersion!;
    if (!Platform.isAndroid) {
      _androidSdkVersion = 0;
      return _androidSdkVersion!;
    }
    try {
      String? platformVersionString =
          await _permissionMaster?.getPlatformVersion();
      if (platformVersionString != null) {
        // Remove "Android " prefix if present (e.g., "Android 13" -> "13")
        if (platformVersionString.startsWith("Android ")) {
          platformVersionString =
              platformVersionString.substring("Android ".length);
        }

        // Get the major version part (e.g., "12" from "12.1" or "12")
        // Build.VERSION.RELEASE typically returns major version like "9", "10", "13"
        int? majorVersion =
            int.tryParse(platformVersionString.split('.').first);

        if (majorVersion != null) {
          // Map platform version number to SDK_INT
          switch (majorVersion) {
            case 9:
              _androidSdkVersion = 28; // Android 9 (Pie)
              break;
            case 10:
              _androidSdkVersion = 29; // Android 10 (Q)
              break;
            case 11:
              _androidSdkVersion = 30; // Android 11 (R)
              break;
            case 12:
              _androidSdkVersion =
                  31; // Android 12 (S). Note: Android 12L (API 32) also has Build.VERSION.RELEASE "12"
              break;
            case 13:
              _androidSdkVersion = 33; // Android 13 (Tiramisu)
              break;
            case 14:
              _androidSdkVersion = 34; // Android 14 (Upside Down Cake)
              break;
            default:
              debugPrint(
                  'Unmapped Android version "$platformVersionString" (parsed major: $majorVersion). Defaulting SDK version to 0.');
              _androidSdkVersion = 0;
          }
        } else {
          debugPrint(
              'Failed to parse Android version from string: "$platformVersionString"');
          _androidSdkVersion = 0;
        }
      } else {
        debugPrint('PermissionMaster.getPlatformVersion() returned null.');
        _androidSdkVersion = 0;
      }
    } catch (e) {
      debugPrint(
          'Error getting Android SDK version using PermissionMaster: $e');
      _androidSdkVersion = 0;
    }
    return _androidSdkVersion!;
  }

  Future<List<XFile>> pickImage(ImageSource imageSource, bool multiple) async {
    // Only request permissions on Android or iOS
    if (Platform.isAndroid || Platform.isIOS) {
      // Request appropriate permissions based on image source
      PermissionStatus permissionStatus;

      if (imageSource == ImageSource.camera) {
        permissionStatus = await _permissionMaster!.requestCameraPermission();
      } else {
        permissionStatus = await _permissionMaster!.requestStoragePermission();
      }

      if (permissionStatus != PermissionStatus.granted) {
        debugPrint('Permission denied for ${imageSource.name}');
        if (permissionStatus == PermissionStatus.openSettings) {
          // Permanent denial, suggest opening app settings
          await _permissionMaster!.openAppSettings();
        }
        return [];
      }
    }

    try {
      if (multiple == true) {
        return await _imagePicker.pickMultiImage();
      } else {
        final file = await _imagePicker.pickImage(
          source: imageSource,
          requestFullMetadata: false, // Attempt to fix Android 9 URI issue
        );
        if (file != null) {
          // Android 9 specific handling
          if (Platform.isAndroid) {
            final sdkVersion = await getAndroidSdkVersion();
            if (sdkVersion == 28) {
              // Android 9 (API 28)
              try {
                final Directory tempDir = await getTemporaryDirectory();
                final String tempPath = tempDir.path;

                // Extract original file extension or default to .jpg
                final String originalFileName = file.name;
                final String extension = originalFileName.contains('.')
                    ? originalFileName
                        .substring(originalFileName.lastIndexOf('.'))
                    : '.jpg';
                final String tempFileName =
                    '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}$extension';

                final File newFile = File('$tempPath/$tempFileName');

                // Read bytes from original XFile and write to new temporary file
                final Uint8List bytes = await file.readAsBytes();
                await newFile.writeAsBytes(bytes);

                return [XFile(newFile.path)];
              } catch (e) {
                debugPrint(
                    'Error copying file to temp directory on Android 9: $e');
                return []; // Return empty if copying fails
              }
            }
          }
          return [file];
        }
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
    return [];
  }

  Future<CroppedFile?> crop(
    XFile file, {
    CropStyle? cropStyle,
    Color? toolbarColor,
    Color? toolbarWidgetColor,
    CropAspectRatioPresetData? initAspectRatio,
    CropAspectRatio? aspectRatio,
    required ImageCompressFormat compressFormat,
    int? compressQuality,
    int? maxHeight,
    int? maxWidth,
  }) async {
    try {
      return await _imageCropper.cropImage(
        sourcePath: file.path,
        aspectRatio: aspectRatio,
        compressFormat: compressFormat,
        compressQuality: compressQuality!,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
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
/*


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_master/permission_master.dart';

class ImageTools {
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;
  final PermissionMaster _permissionMaster = PermissionMaster();

  ImageTools({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  bool multiple = false;
  Future<List<XFile>> pickImage(ImageSource imageSource, bool multiple) async {
    // Request appropriate permissions based on image source
    PermissionStatus permissionStatus;

    if (imageSource == ImageSource.camera) {
      permissionStatus = await _permissionMaster.requestCameraPermission();
    } else {
      permissionStatus = await _permissionMaster.requestStoragePermission();
    }

    if (permissionStatus != PermissionStatus.granted) {
      debugPrint('Permission denied for ${imageSource.name}');
      if (permissionStatus == PermissionStatus.openSettings) {
        // Permanent denial, suggest opening app settings
        await _permissionMaster.openAppSettings();
      }
      return [];
    }

    try {
      if (multiple == true) {
        return await _imagePicker.pickMultiImage();
      } else {
        final file = await _imagePicker.pickImage(source: imageSource);
        if (file != null) {
          return [file];
        }
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
    return [];
  }

  Future<CroppedFile?> crop(
    XFile file, {
    CropStyle? cropStyle,
    Color? toolbarColor,
    Color? toolbarWidgetColor,
    CropAspectRatioPresetData? initAspectRatio,
    CropAspectRatio? aspectRatio,
    required ImageCompressFormat compressFormat,
    int? compressQuality,
    int? maxHeight,
    int? maxWidth,
  }) async {
    try {
      return await _imageCropper.cropImage(
        sourcePath: file.path,
        aspectRatio: aspectRatio,
        compressFormat: compressFormat,
        compressQuality: compressQuality!,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
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
*/
