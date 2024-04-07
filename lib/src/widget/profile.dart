// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:avatar_better/src/widget/isborder_avatar.dart';
import 'package:avatar_better/src/widget/none_border_avatar.dart';
import 'package:avatar_better/web/isweb.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../tools/gradiant_random_tools.dart';
import '../tools/image_tools.dart';
import '../tools/text_to_color.dart';

typedef OnPickerChange = void Function(File file);
typedef OnPickerChangeWeb = void Function(Uint8List file);

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

  /// [backgroundColorCamera] : color background picker
  final Color backgroundColorCamera;

  /// [icon]: icon picker
  final IconData? icon;

  /// [iconColor]: color picker icon
  final Color iconColor;

  ///[onPickerChange ]:is an optional property in the [Picker] class that allows you to call a callback when the picker value changes.
  /// This callback has a parameter named value that passes the new value of the picker to it.
  final OnPickerChange? onPickerChange;

  /// The isBorderAvatar parameter, if true, creates a border for the avatar.
  /// This border contains a circular border with a default width of 5 and a color of LinearGradient.
  /// If this parameter is false, no border will be created for the avatar.
  final bool isBorderAvatar;

  ///[elevation]: elevation color.
  final double elevation;

  /// [shadowColor]: create shadow widget  (can be null).
  final Color? shadowColor;

  /// [onPickerChangeWeb] :is an optional property in the [Picker] class that allows you to call a callback when the picker value changes.
  final OnPickerChangeWeb? onPickerChangeWeb;
  Profile({
    super.key,
    required this.radius,
    required this.text,
    this.onPickerChange,
    this.onPickerChangeWeb,
    this.image,
    this.imageNetwork,
    this.gradientBackgroundColor,
    this.elevation = 0,
    this.shadowColor = Colors.black,
    this.isBorderAvatar = false,
    this.backgroundColor = Colors.green,
    this.gradientWidthBorder =
        const LinearGradient(colors: [Colors.blue, Colors.deepPurple]),
    this.iconColor = Colors.black,
    this.widthBorder = 5.0,
    this.backgroundColorCamera = Colors.white,
    this.icon = Icons.camera,
    this.style = const TextStyle(
        fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
    bool randomColor = true,
    bool randomGradient = false,
  }) {
    if (randomColor) {
      backgroundColor = TextToColor.toColor(text);
    } else if (randomGradient) {
      gradientBackgroundColor =
          GradiantRandomTools.getGradient(text.toString());
    } else {
      backgroundColor = backgroundColor;
    }
  }

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  Uint8List? imageBytesWeb;
  ImageTools imageModel = ImageTools();

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: Stack(
        children: [
          if (kIsWeb)
            IsWeb(
              widget: widget,
              imageBytesWeb: imageBytesWeb,
            )
          else
            widget.isBorderAvatar
                ? IsBorderAvatar(widget: widget, image: image)
                : NoneBorderAvatar(widget: widget, image: image),
          Positioned(
            bottom: widget.radius != null ? widget.radius! / 11 : 0,
            right: widget.radius != null
                ? widget.radius! / 11
                : 0, // نصف ارتفاع AvatarCircle
            child: InkResponse(
              onTap: () {
                customBottomPickerImage();
                // Navigator.pop(context);
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

  void customBottomPickerImage() {
    showModalBottomSheet(
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
                  final List<XFile> file =
                      await imageModel.pickImage(ImageSource.gallery, false);

                  if (file.isNotEmpty) {
                    final croppedFile =
                        await imageModel.crop(file.first, CropStyle.circle);
                    // ignore: use_build_context_synchronously
                    final croppedImageBytes = await imageModel.cropForWeb(
                        // ignore: use_build_context_synchronously
                        file.first,
                        CropStyle.circle,
                        context);

                    if (kIsWeb && croppedImageBytes != null) {
                      setState(() {
                        imageBytesWeb = croppedImageBytes;
                        widget.onPickerChangeWeb?.call(imageBytesWeb!);
                      });
                    } else {
                      setState(() {
                        if (croppedFile != null) {
                          image = File(croppedFile.path);
                          widget.onPickerChange?.call(image!);

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      });
                    }
                  }
                },
                child: Material(
                  borderRadius: BorderRadius.circular(12.0),
                  elevation: 5,
                  color: Colors.grey[100],
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width * 0.90,
                    height: 50,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                        ),
                        Text("Browse Gallery")
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Center(
                child: Text("Or"),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {
                  final List<XFile> file =
                      await imageModel.pickImage(ImageSource.camera, false);

                  if (file.isNotEmpty) {
                    final croppedFile =
                        await imageModel.crop(file.first, CropStyle.circle);
                    // ignore: use_build_context_synchronously
                    final croppedImageBytes = await imageModel.cropForWeb(
                        // ignore: use_build_context_synchronously
                        file.first,
                        CropStyle.circle,
                        // ignore: use_build_context_synchronously
                        context);

                    if (kIsWeb && croppedImageBytes != null) {
                      setState(() {
                        imageBytesWeb = croppedImageBytes;
                        widget.onPickerChangeWeb?.call(imageBytesWeb!);
                      });
                    } else {
                      setState(() {
                        if (croppedFile != null) {
                          image = File(croppedFile.path);
                          widget.onPickerChange?.call(image!);

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      });
                    }
                  }
                },
                child: Material(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12.0),
                  elevation: 5,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width * 0.90,
                    height: 50,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined),
                        Text("Usa camera"),
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
