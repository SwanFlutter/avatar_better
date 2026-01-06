// ignore_for_file: must_be_immutable, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';

import 'package:avatar_better/multiPlatform/multi_platform_profile.dart';
import 'package:avatar_better/src/tools/bottom_sheet_styles.dart';
import 'package:avatar_better/src/tools/options_crop.dart';
import 'package:avatar_better/src/tools/options_crop_wind_mac_linux.dart';
import 'package:avatar_better/src/widget/isborder_avatar.dart';
import 'package:avatar_better/src/widget/none_border_avatar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:picker_image_cropper/picker_image_cropper.dart';

import '../src/tools/extensions/text_to_color.dart';
import '../src/tools/gradiant_random_tools.dart';

typedef OnPickerChange = void Function(File file);
typedef OnPickerChangeWeb = void Function(Uint8List file);
typedef OnPickerCompleted = void Function(File? file, Uint8List? bytes);
typedef OnFilePickerCompleted = void Function(File file);
typedef OnBytesPickerCompleted = void Function(Uint8List bytes);

extension ProfileExtensions on Profile {
  static String initials(String text) {
    String result = "";
    List<String> words = text.split(" ");
    for (var text in words) {
      if (text.trim().isNotEmpty && result.length < 2) {
        result += text[0].trim();
      }
    }
    return result.trim().toUpperCase();
  }
}

/// Example:
///
/// ```dart
/// Profile(
///   text: avatar[index],
///   radius: 35,
///   randomGradient: true,
///   randomColor: false,
/// )
/// ```

class Profile extends StatefulWidget {
  /// [text]: The text to display on the profile.
  final String? text;

  /// [widthBorder]: The border width of the profile [widthBorder = 0.0].
  final double widthBorder;

  /// [radius]: The radius of the profile [radius = 35].
  double? radius;

  /// [image]: The imageAssets for the profile.
  final String? image;

  /// [imageNetwork]: The image URL for the profile.
  final String? imageNetwork;

  /// [backgroundColor]: The background color of the profile (can be null).
  Color? backgroundColor;

  /// [gradientBackgroundColor]: The gradient background of the profile (can be null).
  Gradient? gradientBackgroundColor;

  /// [gradientWidthBorder]: The gradient for the profile's border (default: linear gradient from blue to deep purple).
  Gradient? gradientWidthBorder;

  /// [style]: The text style (default: font size 25, white color, and bold).
  final TextStyle? style;

  /// [backgroundColorCamera]: Color background picker
  final Color backgroundColorCamera;

  /// [icon]: Icon picker
  final IconData? icon;

  /// [iconColor]: Color picker icon
  final Color iconColor;

  /// [onPickerChange]: An optional property in the [Picker] class that allows you to call a callback when the picker value changes.
  /// This callback has a parameter named value that passes the new value of the picker to it.
  final OnPickerChange? onPickerChange;

  /// The [isBorderAvatar] parameter, if true, creates a border for the avatar.
  /// This border contains a circular border with a default width of 5 and a color of LinearGradient.
  /// If this parameter is false, no border will be created for the avatar.
  final bool isBorderAvatar;

  /// [elevation]: Elevation color.
  final double elevation;

  /// [shadowColor]: Create shadow widget (can be null).
  final Color? shadowColor;

  /// [onPickerChangeWeb]: An optional property in the [Picker] class that allows you to call a callback when the picker value changes.
  final OnPickerChangeWeb? onPickerChangeWeb;

  /// [onPickerCompleted]: Callback when both file and bytes are available.
  final OnPickerCompleted? onPickerCompleted;

  /// [onFilePickerCompleted]: Callback when file is ready.
  final OnFilePickerCompleted? onFilePickerCompleted;

  /// [onBytesPickerCompleted]: Callback when bytes are ready.
  final OnBytesPickerCompleted? onBytesPickerCompleted;

  /// [OptionsCrop]: Configuration options for image cropping functionality.
  final OptionsCrop? optionsCrop;

  /// [BottomSheetStyles]: Configuration for customizing the bottom sheet's appearance and behavior.
  final BottomSheetStyles? bottomSheetStyles;

  final OptionsCropWindMacLinux? optionsCropWindMacLinux;

  /// [useMaterialColorForGradient]: Use material color for gradient. Default = true
  final bool useMaterialColorForGradient;

  /// [mixColorForGradient]: Mix color for gradient. Default = false
  final bool mixColorForGradient;

  /// [child]: The child widget to display inside the avatar.
  final Widget? child;

  Profile({
    super.key,
    required this.radius,
    required this.text,
    this.onPickerChange,
    this.onPickerChangeWeb,
    this.onPickerCompleted,
    this.onFilePickerCompleted,
    this.onBytesPickerCompleted,
    this.image,
    this.imageNetwork,
    this.gradientBackgroundColor,
    this.elevation = 0,
    this.shadowColor = Colors.black,
    this.isBorderAvatar = false,
    this.backgroundColor = Colors.green,
    this.bottomSheetStyles,
    this.gradientWidthBorder = const LinearGradient(
      colors: [Colors.blue, Colors.deepPurple],
    ),
    this.iconColor = Colors.black,
    this.widthBorder = 5.0,
    this.backgroundColorCamera = Colors.white,
    this.icon = Icons.camera,
    this.optionsCrop,
    this.optionsCropWindMacLinux,
    this.style = const TextStyle(
      fontSize: 25,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    bool randomColor = true,
    bool randomGradient = false,
    this.useMaterialColorForGradient = true,
    this.mixColorForGradient = false,
    this.child,
  }) {
    if (randomColor && randomGradient) {
      throw Exception(
        'Both randomColor and randomGradient cannot be true simultaneously.',
      );
    }

    if ((randomColor || randomGradient) &&
        ((backgroundColor != null && backgroundColor != Colors.green) ||
            gradientBackgroundColor != null)) {
      throw Exception(
        'backgroundColor or gradientBackgroundColor cannot be set when randomColor or randomGradient is active.',
      );
    }

    if (randomColor) {
      backgroundColor = TextToColor.toColor(text);
    } else if (randomGradient) {
      gradientBackgroundColor = GradientRandomTools.getGradient(
        text.toString(),
        material: useMaterialColorForGradient,
        dynamicMix: mixColorForGradient,
      );
    }
  }

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  Uint8List? multiPlatformByte;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: Stack(
        children: [
          kIsWeb
              ? MultiPlatform(profile: widget, imageBytesWeb: multiPlatformByte)
              : widget.isBorderAvatar
              ? IsBorderAvatar(widget: widget, image: image)
              : NoneBorderAvatar(widget: widget, image: image),
          Positioned(
            bottom: widget.radius != null ? widget.radius! / 11 : 0,
            right: widget.radius != null ? widget.radius! / 11 : 0,
            child: InkResponse(
              onTap: () {
                customBottomPickerImage(context);
              },
              child: CircleAvatar(
                radius: widget.radius != null ? widget.radius! / 3.5 : 0,
                backgroundColor: widget.backgroundColorCamera,
                child: Icon(
                  widget.icon,
                  color: widget.iconColor,
                  size: widget.radius != null ? widget.radius! / 2 : 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void customBottomPickerImage(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: widget.bottomSheetStyles?.backgroundColor,
      elevation: widget.bottomSheetStyles?.elevation,
      shape: widget.bottomSheetStyles?.shape,
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return SizedBox(
          width: size.width,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  try {
                    // Use the new picker_image_cropper package with callback for gallery
                    await ImagePickerCropper.pickAndCropWithCallback(
                      context: context,
                      fromCamera: false,
                      onCompleted: (file, bytes) {
                        setState(() {
                          if (kIsWeb) {
                            multiPlatformByte = bytes;
                            widget.onPickerChangeWeb?.call(bytes!);
                          } else {
                            image = file;
                            widget.onPickerChange?.call(file!);
                          }
                          // Call new callbacks
                          widget.onPickerCompleted?.call(file, bytes);
                          Navigator.pop(context);
                        });
                      },
                      onFileCompleted: (file) {
                        widget.onFilePickerCompleted?.call(file);
                      },
                      onBytesCompleted: (bytes) {
                        widget.onBytesPickerCompleted?.call(bytes);
                      },
                      theme: widget.optionsCrop?.cropperTheme,
                      aspectRatio: widget.optionsCrop?.aspectRatio,
                      labels: widget.optionsCrop?.labels ?? CropperLabels(),
                    );
                  } catch (e) {
                    debugPrint('Error in image picking process: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('An error occurred. Please try again.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Material(
                  borderRadius: BorderRadius.circular(12.0),
                  elevation: 5,
                  color: widget.bottomSheetStyles?.galleryButton?.color,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width * 0.90,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.bottomSheetStyles?.galleryButton?.icon !=
                            null)
                          widget.bottomSheetStyles!.galleryButton!.icon!,
                        Text(
                          widget.bottomSheetStyles?.galleryButton?.text ??
                              "Browse Gallery",
                          style: widget.bottomSheetStyles?.galleryButton?.style,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  widget.bottomSheetStyles?.middleText ?? "OR",
                  style: widget.bottomSheetStyles?.middleTextStyle,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () async {
                  try {
                    // Use the new picker_image_cropper package with callback for camera
                    await ImagePickerCropper.pickAndCropWithCallback(
                      context: context,
                      fromCamera: true,
                      onCompleted: (file, bytes) {
                        setState(() {
                          if (kIsWeb) {
                            multiPlatformByte = bytes;
                            widget.onPickerChangeWeb?.call(bytes!);
                          } else {
                            image = file;
                            widget.onPickerChange?.call(file!);
                          }
                          // Call new callbacks
                          widget.onPickerCompleted?.call(file, bytes);
                          Navigator.pop(context);
                        });
                      },
                      onFileCompleted: (file) {
                        widget.onFilePickerCompleted?.call(file);
                      },
                      onBytesCompleted: (bytes) {
                        widget.onBytesPickerCompleted?.call(bytes);
                      },
                      theme: widget.optionsCrop?.cropperTheme,
                      aspectRatio: widget.optionsCrop?.aspectRatio,
                      labels: widget.optionsCrop?.labels ?? CropperLabels(),
                    );
                  } catch (e) {
                    debugPrint('Error in camera image picking: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'An error occurred with the camera. Please try again.',
                        ),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Material(
                  color: widget.bottomSheetStyles?.cameraButton?.color,
                  borderRadius: BorderRadius.circular(12.0),
                  elevation: 5,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width * 0.90,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.bottomSheetStyles?.cameraButton?.icon !=
                            null)
                          widget.bottomSheetStyles!.cameraButton!.icon!,
                        Text(
                          widget.bottomSheetStyles?.cameraButton?.text ??
                              "Use Camera",
                          style: widget.bottomSheetStyles?.cameraButton?.style,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
