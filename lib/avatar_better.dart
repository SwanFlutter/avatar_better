// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unnecessary_null_comparison

library;

import 'dart:io';

import 'package:avatar_better/profile/profile.dart';
import 'package:avatar_better/src/tools/bottom_sheet_styles.dart';
import 'package:avatar_better/src/tools/extensions/text_to_color.dart';
import 'package:avatar_better/src/tools/gradiant_random_tools.dart';
import 'package:avatar_better/src/tools/gradient_circle_painter.dart';
import 'package:avatar_better/src/tools/options_crop.dart';
import 'package:avatar_better/src/tools/profile_image_viewer_options.dart';
import 'package:avatar_better/src/widget/page_view.dart';
import 'package:flutter/material.dart';

export 'package:avatar_better/src/tools/bottom_sheet_styles.dart';
export 'package:avatar_better/src/tools/gallery_buttom.dart';
export 'package:avatar_better/src/tools/options_crop.dart';
export 'package:avatar_better/src/tools/options_crop_wind_mac_linux.dart';
export 'package:avatar_better/src/tools/profile_image_viewer_options.dart';
export 'package:flutter_saver/flutter_saver.dart';
export 'package:picker_image_cropper/picker_image_cropper.dart';

typedef OnPickerChange = void Function(File file);

extension AvatarCircleExtensions on Avatar {
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

/// A widget that displays an avatar image.
///
///Example:
///
///```dart
///Avatar(
///onTapAvatar: () {},//With this function, you can display page shift or page view in a personalized way.
///text: avatar[index],
///radius: 35,
///randomGradient: true,
///randomColor: false,
///imageNetwork: "https://images.unsplash.com/photo-1616731948638-b0d0befef759?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
/// showPageViewOnTap: true, //By activating this option, the user can see the avatar images in the page view.
/// )
/// ```
/// [text]: The text to display on the avatar.
///
/// [widthBorder]: The border width of the avatar (default: 0.0).
///
/// [radius]: The radius of the avatar size.
///
/// [image]: The imageAssets for the avatar.
///
/// [imageNetwork]: The image URL for the avatar.
///
/// [backgroundColor]: The background color of the avatar (can be null).
///
/// [gradientBackgroundColor]: The gradient background of the avatar (can be null).
///
/// [gradientWidthBorder]: The gradient for the avatar's border (default: linear gradient from blue to deep purple).

class Avatar extends StatefulWidget {
  /// [onTapAvatar]: A callback function for when the avatar is tapped.
  final void Function()? onTapAvatar;

  /// [widthBorder]: The border width of the profile (default: 0.0).
  final double widthBorder;

  /// [radius]: The radius of the profile size.
  final double? radius;

  /// [image]: The imageAssets for the profile.
  final String? image;

  /// [imageNetwork]: The image URL list for pageView profile.
  final String? imageNetwork;

  /// [listImageNetwork]: The images URL for the profile.
  final List<String>? listImageNetwork;

  /// [backgroundColor]: The background color of the profile (can be null).
  Color? backgroundColor;

  /// [gradientBackgroundColor]: The gradient background of the profile (can be null).
  Gradient? gradientBackgroundColor;

  /// [gradientWidthBorder]: The gradient for the profile's border (default: linear gradient from blue to deep purple).
  final Gradient? gradientWidthBorder;

  /// [elevation]: create shadow widget (can be null).
  final double elevation;

  ///[shadowColor]: elevation color.
  final Color? shadowColor;

  /// [text]: The text to display on the profile.
  final String? text;

  /// [style]: The text style (default: font size 25, white color, and bold).
  final TextStyle? style;

  /// The [isBorderAvatar] parameter, if true, creates a border for the avatar.
  /// This border contains a circular border with a default width of 5 and a color of [LinearGradient].
  /// If this parameter is false, no border will be created for the avatar.
  final bool isBorderAvatar;

  ///[showPageViewOnTap] If the showPageViewOnTap property is false, then the onTapAvatar callback is executed. This is the default behavior.
  ///If the showPageViewOnTap property is true, then a PageView is displayed.
  /// The PageView will contain the images specified by the imagePicker and imageAsset and Network properties.
  final bool showPageViewOnTap;

  /// [profileImageViewerOptions]: The options for the profile image viewer.
  final ProfileImageViewerOptions? profileImageViewerOptions;

  /// [itemsBuilderDropdownMenuItem]: The builder function for the dropdown menu items in page view.
  final List<DropdownMenuItem<String>>? Function(int index)?
  itemsBuilderDropdownMenuItem;

  /// [useMaterialColorForGradient]: Use material color for gradient. Default = true
  final bool useMaterialColorForGradient;

  /// [mixColorForGradient]: Mix color for gradient. Default = false
  final bool mixColorForGradient;

  /// [child]: The child widget to display inside the avatar.
  final Widget? child;

  Avatar({
    super.key,
    required this.text,
    this.profileImageViewerOptions,
    this.onTapAvatar,
    this.radius = 35,
    this.image,
    this.imageNetwork,
    this.listImageNetwork,
    this.backgroundColor,
    this.gradientBackgroundColor,
    this.shadowColor = Colors.black,
    this.gradientWidthBorder = const LinearGradient(
      colors: [Colors.blue, Colors.deepPurple],
    ),
    this.elevation = 0,
    this.widthBorder = 5.0,
    this.isBorderAvatar = false,
    this.showPageViewOnTap = false,
    this.itemsBuilderDropdownMenuItem = defaultItemsBuilder,
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
        (backgroundColor != null || gradientBackgroundColor != null)) {
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

  static Widget profile({
    /// [text]: The text to display on the profile.
    required String? text,

    /// [widthBorder]: The border width of the profile [widthBorder = 0.0].
    final double widthBorder = 0.0,

    /// [radius]: The radius of the profile [radius = 35].
    double? radius = 35,

    /// [image]: The imageAssets for the profile.
    final String? image,

    /// [imageNetwork]: The image URL for the profile.
    final String? imageNetwork,

    /// [backgroundColor]: The background color of the profile (can be null).
    Color? backgroundColor,

    /// [gradientBackgroundColor]: The gradient background of the profile (can be null).
    Gradient? gradientBackgroundColor,

    /// [gradientWidthBorder]: The gradient for the profile's border (default: linear gradient from blue to deep purple).
    Gradient? gradientWidthBorder = const LinearGradient(
      colors: [Colors.blue, Colors.deepPurple],
    ),

    /// [style]: The text style (default: font size 25, white color, and bold).
    final TextStyle? style = const TextStyle(
      fontSize: 25,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),

    /// [backgroundColorCamera]: Color background picker
    final Color backgroundColorCamera = Colors.white,

    /// [icon]: Icon picker
    final IconData? icon = Icons.camera,

    /// [iconColor]: Color picker icon
    final Color iconColor = Colors.black,

    /// [randomColor]: A boolean flag for randomizing the background color of the profile.
    bool randomColor = true,

    /// [randomGradient]: A boolean flag for randomizing the background gradient of the profile.
    bool randomGradient = false,

    ///[elevation]: Elevation color.
    final double elevation = 0,

    /// [shadowColor]: Create shadow widget (can be null).
    final Color shadowColor = Colors.black,

    ///[onPickerChange]: Is an optional property in the [Picker] class that allows you to call a callback when the picker value changes.
    /// This callback has a parameter named value that passes the new value of the picker to it.
    final OnPickerChange? onPickerChange,

    /// The [isBorderAvatar] parameter, if true, creates a border for the avatar.
    /// This border contains a circular border with a default width of 5 and a color of LinearGradient.
    /// If this parameter is false, no border will be created for the avatar.
    final bool isBorderAvatar = false,

    /// This section of code pertains to the definition of a callback that is invoked when a file is selected by the user.
    ///
    /// `OnPickerChangeWeb` is a data type representing a function that takes an argument of type `Uint8List` and returns nothing (`void`).
    ///
    /// This callback is used as a parameter in a function or class responsible for file selection or change. When a user selects a file and the selection process completes, this callback is invoked, and the selected file is passed to it as an argument.
    ///
    /// The default value for this parameter is `null`, but you can specify a function as a default value to be called if no function is selected.
    final OnPickerChangeWeb? onPickerChangeWeb,

    /// [OptionsCrop]: Configuration options for image cropping functionality.
    final OptionsCrop? optionsCrop,

    /// [BottomSheetStyles]: Configuration for customizing the bottom sheet's appearance and behavior.
    final BottomSheetStyles? bottomSheetStyles,

    /// [useMaterialColorForGradient]: Use material color for gradient
    final bool useMaterialColorForGradient = true,

    /// [mixColorForGradient]: Mix color for gradient
    final bool mixColorForGradient = false,

    /// [child]: Child widget
    final Widget? child,
  }) {
    if (randomColor && randomGradient) {
      throw Exception(
        'Both randomColor and randomGradient cannot be true simultaneously.',
      );
    }

    if ((randomColor || randomGradient) &&
        (backgroundColor != null || gradientBackgroundColor != null)) {
      throw Exception(
        'backgroundColor or gradientBackgroundColor cannot be set when randomColor or randomGradient is active.',
      );
    }

    Color? finalBackgroundColor = backgroundColor;
    Gradient? finalGradientBackgroundColor = gradientBackgroundColor;
    bool finalRandomColor = randomColor;
    bool finalRandomGradient = randomGradient;

    if (randomColor) {
      finalBackgroundColor = TextToColor.toColor(text);
      finalRandomColor =
          false; // Disable in Profile to avoid re-calc and exception
    } else if (randomGradient) {
      finalGradientBackgroundColor = GradientRandomTools.getGradient(
        text.toString(),
        material: useMaterialColorForGradient,
        dynamicMix: mixColorForGradient,
      );
      finalRandomGradient =
          false; // Disable in Profile to avoid re-calc and exception
    }

    return Profile(
      widthBorder: widthBorder,
      radius: radius,
      image: image,
      imageNetwork: imageNetwork,
      backgroundColor: finalBackgroundColor,
      gradientWidthBorder: gradientWidthBorder,
      gradientBackgroundColor: finalGradientBackgroundColor,
      text: text,
      style: style,
      backgroundColorCamera: backgroundColorCamera,
      icon: icon,
      iconColor: iconColor,
      randomColor: finalRandomColor,
      randomGradient: finalRandomGradient,
      onPickerChange: onPickerChange,
      isBorderAvatar: isBorderAvatar,
      shadowColor: shadowColor,
      elevation: elevation,
      onPickerChangeWeb: onPickerChangeWeb,
      optionsCrop: optionsCrop,
      bottomSheetStyles: bottomSheetStyles,
      child: child,
    );
  }

  @override
  State<Avatar> createState() => _AvatarState();
  static List<DropdownMenuItem<String>> defaultItemsBuilder(int index) {
    return [];
  }
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    File? imagePicker;
    return InkResponse(
      onTap: widget.showPageViewOnTap
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageViewAvatar(
                    imageNetwork: widget.imageNetwork,
                    image: widget.image,
                    imagePicker: imagePicker,
                    listImageNetwork: widget.listImageNetwork,
                    namePageview: widget.text!.toLowerCase(),
                    backBottomColor: widget
                        .profileImageViewerOptions
                        ?.backBottomColorPageView,
                    backgroundColorDropdownMenuItem: widget
                        .profileImageViewerOptions
                        ?.backgroundColorDropdownMenuItem,
                    iconColorDropdownMenuItem: widget
                        .profileImageViewerOptions
                        ?.iconColorDropdownMenuItem,
                    backgroundColorPageViewAppBar: widget
                        .profileImageViewerOptions
                        ?.backgroundColorPageViewAppBar,
                    widgetLoadingPageView:
                        widget.profileImageViewerOptions?.widgetLoadingPageView,
                    fitBackgroundImage:
                        widget.profileImageViewerOptions?.fitBackgroundImage,
                    widget: widget,
                  ),
                ),
              );
            }
          : widget.onTapAvatar,
      child: widget.isBorderAvatar
          ? CustomPaint(
              painter: GradientCirclePainter(
                gradientColors: widget.gradientWidthBorder,
                withBorder: widget.widthBorder,
              ),
              child: Material(
                type: MaterialType.circle,
                elevation: widget.elevation,
                shadowColor: widget.shadowColor,
                color: Colors.transparent,
                borderRadius: null,
                child: Container(
                  alignment: Alignment.center,
                  height: widget.radius != null ? widget.radius! * 2.2 : 35,
                  width: widget.radius != null ? widget.radius! * 2.2 : 35,
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    gradient: widget.gradientBackgroundColor,
                    shape: BoxShape.circle,
                    image: imagePicker != null
                        ? DecorationImage(
                            image: FileImage(imagePicker),
                            fit: BoxFit.cover,
                          )
                        : widget.imageNetwork != null ||
                              widget.listImageNetwork != null
                        ? DecorationImage(
                            image: Image.network(
                              widget.imageNetwork != null
                                  ? widget.imageNetwork!
                                  : widget.listImageNetwork!.last,
                            ).image,
                            fit: BoxFit.cover,
                          )
                        : widget.image != null
                        ? DecorationImage(
                            image: Image.asset(widget.image!).image,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child:
                      widget.child ??
                      (widget.imageNetwork == null &&
                              widget.image == null &&
                              widget.listImageNetwork == null &&
                              widget.text != null
                          ? Text(
                              AvatarCircleExtensions.initials(widget.text!),
                              style: widget.style,
                            )
                          : const Text('')),
                ),
              ),
            )
          : Material(
              type: MaterialType.circle,
              elevation: widget.elevation,
              shadowColor: widget.shadowColor,
              color: Colors.transparent,
              borderRadius: null,
              child: Container(
                alignment: Alignment.center,
                height: widget.radius != null ? widget.radius! * 2.2 : 35,
                width: widget.radius != null ? widget.radius! * 2.2 : 35,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  gradient: widget.gradientBackgroundColor,
                  shape: BoxShape.circle,
                  image: imagePicker != null
                      ? DecorationImage(
                          image: FileImage(imagePicker),
                          fit: BoxFit.cover,
                        )
                      : widget.imageNetwork != null ||
                            widget.listImageNetwork != null
                      ? DecorationImage(
                          image: Image.network(
                            widget.imageNetwork != null
                                ? widget.imageNetwork!
                                : widget.listImageNetwork!.last,
                          ).image,
                          fit: BoxFit.cover,
                        )
                      : widget.image != null
                      ? DecorationImage(
                          image: Image.asset(widget.image!).image,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child:
                    widget.child ??
                    (widget.imageNetwork == null &&
                            widget.image == null &&
                            widget.listImageNetwork == null &&
                            widget.text != null
                        ? Text(
                            AvatarCircleExtensions.initials(widget.text!),
                            style: widget.style,
                          )
                        : const Text('')),
              ),
            ),
    );
  }
}
