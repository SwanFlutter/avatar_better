import 'package:avatar_better/profile/profile.dart';
import 'package:avatar_better/src/tools/gradient_circle_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MultiPlatform extends StatelessWidget {
  /// Represents a profile widget.
  final Profile profile;

  /// Represents the image bytes for web.
  final Uint8List? imageBytesWeb;

  const MultiPlatform({
    super.key,
    required this.profile,
    required this.imageBytesWeb,
  });
  @override
  Widget build(BuildContext context) {
    DecorationImage? decorationImage;
    if (imageBytesWeb != null) {
      decorationImage = DecorationImage(
        image: MemoryImage(Uint8List.fromList(imageBytesWeb!)),
        fit: BoxFit.cover,
      );
    } else if (profile.imageNetwork != null) {
      decorationImage = DecorationImage(
        image: NetworkImage(profile.imageNetwork!),
        fit: BoxFit.cover,
      );
    } else if (profile.image != null) {
      decorationImage = DecorationImage(
        image: AssetImage(profile.image!),
        fit: BoxFit.cover,
      );
    }
    return profile.isBorderAvatar
        ? CustomPaint(
            painter: GradientCirclePainter(
              gradientColors: profile.gradientWidthBorder,
              withBorder: profile.widthBorder,
            ),
            child: Material(
              type: MaterialType.circle,
              elevation: profile.elevation,
              shadowColor: profile.shadowColor,
              color: Colors.transparent,
              borderRadius: null,
              child: Container(
                alignment: Alignment.center,
                height: profile.radius != null ? profile.radius! * 2.2 : 35,
                width: profile.radius != null ? profile.radius! * 2.2 : 35,
                decoration: BoxDecoration(
                  color: profile.backgroundColor,
                  gradient: profile.gradientBackgroundColor,
                  shape: BoxShape.circle,
                  image: decorationImage,
                ),
                child:
                    (imageBytesWeb == null &&
                        profile.imageNetwork == null &&
                        profile.image == null &&
                        profile.text != null)
                    ? Text(
                        ProfileExtensions.initials(profile.text!),
                        style: profile.style,
                      )
                    : const Text(''),
              ),
            ),
          )
        : Material(
            type: MaterialType.circle,
            elevation: profile.elevation,
            shadowColor: profile.shadowColor,
            color: Colors.transparent,
            borderRadius: null,
            child: Container(
              alignment: Alignment.center,
              height: profile.radius != null ? profile.radius! * 2.2 : 35,
              width: profile.radius != null ? profile.radius! * 2.2 : 35,
              decoration: BoxDecoration(
                color: profile.backgroundColor,
                gradient: profile.gradientBackgroundColor,
                shape: BoxShape.circle,
                image: decorationImage,
              ),
              child:
                  (imageBytesWeb == null &&
                      profile.imageNetwork == null &&
                      profile.image == null &&
                      profile.text != null)
                  ? Text(
                      ProfileExtensions.initials(profile.text!),
                      style: profile.style,
                    )
                  : const Text(''),
            ),
          );
  }
}
