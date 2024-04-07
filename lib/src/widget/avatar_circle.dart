// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:avatar_better/src/widget/page_view.dart';
import 'package:flutter/material.dart';

import '../tools/gradiant_random_tools.dart';
import '../tools/gradient_circle_painter.dart';
import '../tools/text_to_color.dart';

extension AvatarCircleExtensions on Circle {
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

class Circle extends StatelessWidget {
  void Function()? onTapAvatar;
  final double widthBorder;
  final double? radius;
  final String? image;
  final String? imageNetwork;
  final List<String>? listImageNetwork;
  Color? backgroundColor;
  Gradient? gradientBackgroundColor;
  Gradient? gradientWidthBorder;
  final double elevation;
  final Color? shadowColor;
  final String? text;
  final TextStyle? style;

  /// The isBorderAvatar parameter, if true, creates a border for the avatar.
  /// This border contains a circular border with a default width of 5 and a color of LinearGradient.
  /// If this parameter is false, no border will be created for the avatar.
  final bool isBorderAvatar;

  final bool showPageViewOnTap;

  final TextStyle? stylePageViewTextName;

  final Color? backgroundColorPageViewAppBar;

  final void Function()? onTapPageViewDelete;

  final Widget? widgetLoadingPageView;

  final Color? backgroundColorDropdownMenuItem;

  final Color? iconColorDropdownMenuItem;

  final Color? backBottomColor;

  Circle({
    Key? key,
    required this.text,
    this.onTapAvatar,
    this.radius = 35,
    this.image,
    this.imageNetwork,
    this.listImageNetwork,
    this.backgroundColor,
    this.gradientBackgroundColor,
    this.stylePageViewTextName = const TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22.0),
    this.backgroundColorPageViewAppBar = Colors.white,
    this.onTapPageViewDelete,
    this.widgetLoadingPageView,
    this.backgroundColorDropdownMenuItem = Colors.white,
    this.iconColorDropdownMenuItem = Colors.black,
    this.backBottomColor = Colors.black,
    this.shadowColor = Colors.black,
    this.gradientWidthBorder =
        const LinearGradient(colors: [Colors.blue, Colors.deepPurple]),
    this.elevation = 0,
    this.widthBorder = 5.0,
    this.isBorderAvatar = false,
    this.showPageViewOnTap = false,
    this.style = const TextStyle(
        fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
    bool randomColor = true,
    bool randomGradient = false,
  }) : super(key: key) {
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
  Widget build(BuildContext context) {
    File? imagePicker;
    return InkResponse(
      onTap: showPageViewOnTap
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageViewAvatar(
                    imageNetwork: imageNetwork,
                    image: image,
                    imagePicker: imagePicker,
                    listImageNetwork: listImageNetwork,
                    namePageview: text!.toLowerCase(),
                    backBottomColor: backBottomColor,
                    backgroundColorDropdownMenuItem:
                        backgroundColorDropdownMenuItem,
                    iconColorDropdownMenuItem: iconColorDropdownMenuItem,
                    backgroundColorPageViewAppBar:
                        backgroundColorPageViewAppBar,
                    onTapPageViewDelete: onTapPageViewDelete,
                    widgetLoadingPageView: widgetLoadingPageView,
                  ),
                ),
              );
            }
          : onTapAvatar,
      child: isBorderAvatar
          ? CustomPaint(
              painter: GradientCirclePainter(
                gradientColors: gradientWidthBorder,
                withBorder: widthBorder,
              ),
              child: Material(
                type: MaterialType.circle,
                elevation: elevation,
                shadowColor: shadowColor,
                color: Colors.transparent,
                borderRadius: null,
                child: Container(
                  alignment: Alignment.center,
                  height: radius != null ? radius! * 2.2 : 35,
                  width: radius != null ? radius! * 2.2 : 35,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    gradient: gradientBackgroundColor,
                    shape: BoxShape.circle,
                    // ignore: unnecessary_null_comparison
                    image: imagePicker != null
                        ? DecorationImage(
                            image: FileImage(imagePicker),
                            fit: BoxFit.cover,
                          )
                        : imageNetwork != null || listImageNetwork != null
                            ? DecorationImage(
                                image: Image.network(imageNetwork != null
                                        ? imageNetwork!
                                        : listImageNetwork!.last)
                                    .image,
                                fit: BoxFit.cover,
                              )
                            : image != null
                                ? DecorationImage(
                                    image: Image.asset(image!).image,
                                    fit: BoxFit.cover,
                                  )
                                : null,
                  ),
                  // ignore: unnecessary_null_comparison
                  child: (imagePicker == null &&
                          imageNetwork == null &&
                          image == null &&
                          listImageNetwork == null &&
                          text != null)
                      ? Text(
                          AvatarCircleExtensions.initials(text!),
                          style: style,
                        )
                      : const Text(''),
                ),
              ),
            )
          : Material(
              type: MaterialType.circle,
              elevation: elevation,
              shadowColor: shadowColor,
              color: Colors.transparent,
              borderRadius: null,
              child: Container(
                alignment: Alignment.center,
                height: radius != null ? radius! * 2.2 : 35,
                width: radius != null ? radius! * 2.2 : 35,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  gradient: gradientBackgroundColor,
                  shape: BoxShape.circle,
                  // ignore: unnecessary_null_comparison
                  image: imagePicker != null
                      ? DecorationImage(
                          image: FileImage(imagePicker),
                          fit: BoxFit.cover,
                        )
                      : imageNetwork != null || listImageNetwork != null
                          ? DecorationImage(
                              image: Image.network(imageNetwork != null
                                      ? imageNetwork!
                                      : listImageNetwork!.last)
                                  .image,
                              fit: BoxFit.cover,
                            )
                          : image != null
                              ? DecorationImage(
                                  image: Image.asset(image!).image,
                                  fit: BoxFit.cover,
                                )
                              : null,
                ),
                // ignore: unnecessary_null_comparison
                child: (imagePicker == null &&
                        imageNetwork == null &&
                        image == null &&
                        listImageNetwork == null &&
                        text != null)
                    ? Text(
                        AvatarCircleExtensions.initials(text!),
                        style: style,
                      )
                    : const Text(''),
              ),
            ),
    );
  }
}
