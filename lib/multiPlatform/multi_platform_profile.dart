import 'package:avatar_better/src/tools/gradient_circle_painter.dart';
import 'package:avatar_better/src/widget/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MultiPlatform extends StatelessWidget {
  /// Represents a profile widget.
  final Profile widget;

  /// Represents the image bytes for web.
  final Uint8List? imageBytesWeb;

  const MultiPlatform({
    super.key,
    required this.widget,
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
    } else if (widget.imageNetwork != null) {
      decorationImage = DecorationImage(
        image: NetworkImage(widget.imageNetwork!),
        fit: BoxFit.cover,
      );
    } else if (widget.image != null) {
      decorationImage = DecorationImage(
        image: AssetImage(widget.image!),
        fit: BoxFit.cover,
      );
    }
    return widget.isBorderAvatar
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
                  image: decorationImage,
                ),
                child: (imageBytesWeb == null &&
                        widget.imageNetwork == null &&
                        widget.image == null &&
                        widget.text != null)
                    ? Text(
                        ProfileExtensions.initials(widget.text!),
                        style: widget.style,
                      )
                    : const Text(''),
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
                image: decorationImage,
              ),
              child: (imageBytesWeb == null &&
                      widget.imageNetwork == null &&
                      widget.image == null &&
                      widget.text != null)
                  ? Text(
                      ProfileExtensions.initials(widget.text!),
                      style: widget.style,
                    )
                  : const Text(''),
            ),
          );
  }
}
