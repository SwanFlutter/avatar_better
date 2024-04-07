import 'dart:io';

import 'package:avatar_better/src/tools/save_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader_web/image_downloader_web.dart';

class PageViewAvatar extends StatefulWidget {
  ///
  ///
  /// Represents a list of network images that can be displayed.
  ///
  final List<String>? listImageNetwork;

  /// Represents a local image file path.
  final String? image;

  /// Represents a network image URL.
  final String? imageNetwork;

  /// Represents an image selected from the device's storage.
  final File? imagePicker;

  /// Represents the name of the page view.
  final String? namePageview;

  /// Represents the text style for the page view's name.
  final TextStyle? stylePageViewTextName;

  /// Represents the background color of the app bar in the page view.
  final Color? backgroundColorPageViewAppBar;

  /// Represents the callback function triggered when the delete button in the page view is tapped.
  final void Function()? onTapPageViewDelete;

  /// Represents the widget to be displayed while loading the page view.
  final Widget? widgetLoadingPageView;

  /// Represents the background color of dropdown menu items.
  final Color? backgroundColorDropdownMenuItem;

  /// Represents the icon color of dropdown menu items.
  final Color? iconColorDropdownMenuItem;

  /// Represents the background color of the bottom section.
  final Color? backBottomColor;

  const PageViewAvatar({
    super.key,
    required this.imagePicker,
    this.image,
    this.imageNetwork,
    this.listImageNetwork,
    this.namePageview,
    this.stylePageViewTextName = const TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22.0),
    this.backgroundColorPageViewAppBar = Colors.white,
    this.onTapPageViewDelete,
    this.widgetLoadingPageView,
    this.backgroundColorDropdownMenuItem = Colors.white,
    this.iconColorDropdownMenuItem = Colors.black,
    this.backBottomColor = Colors.black,
  });

  @override
  State<PageViewAvatar> createState() => _PageViewAvatarState();
}

class _PageViewAvatarState extends State<PageViewAvatar> {
  late PageController _pageController;
  final pageController = PageController();
  late int imageIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var sortedListImageNetwork =
        List<String>.from(widget.listImageNetwork ?? []);
    sortedListImageNetwork.sort((a, b) => a.length.compareTo(b.length));

    var sortedListImage = List<String>.from(widget.listImageNetwork ?? []);
    var lastImageIndex = sortedListImageNetwork.length - 1;
    for (var i = lastImageIndex; i >= 0; i--) {
      sortedListImage.add(sortedListImageNetwork[i]);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: widget.backBottomColor),
          title: Text(
            widget.namePageview != null ? widget.namePageview! : "",
            style: widget.stylePageViewTextName,
          ),
          backgroundColor: widget.backgroundColorPageViewAppBar ??
              Theme.of(context).primaryColorLight,
          actions: [
            DropdownButton(
              dropdownColor: widget.backgroundColorDropdownMenuItem ??
                  Theme.of(context).primaryColorLight,
              icon: Icon(Icons.more_vert,
                  color: widget.iconColorDropdownMenuItem),
              underline: const Divider(color: Colors.transparent),
              items: [
                DropdownMenuItem<String>(
                  value: 'save',
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.image),
                      Text('Save to Gallery '),
                      Text(''),
                    ],
                  ),
                  onTap: () async {
                    if (kIsWeb) {
                      if (widget.imageNetwork != null) {
                        await WebImageDownloader.downloadImageFromWeb(
                            widget.imageNetwork!);
                      } else if (widget.imagePicker != null) {
                        await WebImageDownloader.downloadImageFromWeb(
                            widget.imagePicker!.path);
                      } else if (widget.listImageNetwork != null &&
                          widget.listImageNetwork!.isNotEmpty) {
                        await WebImageDownloader.downloadImageFromWeb(
                            widget.listImageNetwork![imageIndex]);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            padding: EdgeInsets.all(15.0),
                            shape: BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            content: Text(
                              "No valid image to download",
                            ),
                          ),
                        );
                      }
                    } else {
                      if (widget.imagePicker != null) {
                        await ImageSaver.saveImageFile(widget.imagePicker!);
                      } else if (widget.imageNetwork != null) {
                        await ImageSaver.saveImage(widget.imageNetwork!);
                      } else if (widget.listImageNetwork != null &&
                          widget.listImageNetwork!.isNotEmpty) {
                        await ImageSaver.saveImage(
                            widget.listImageNetwork![imageIndex]);
                      } else {
                        // اگر هیچ یک از شرایط بالا برقرار نبود، یک پیغام خطا یا اطلاعیه مناسب برگردانید.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            padding: EdgeInsets.all(15.0),
                            shape: BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            content: Text(
                              "No valid image to download",
                            ),
                          ),
                        );
                      }
                    }

                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        padding: const EdgeInsets.all(15.0),
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        content: Text(
                          (widget.image != null &&
                                  widget.imageNetwork == null &&
                                  widget.imagePicker == null &&
                                  widget.listImageNetwork == null)
                              ? "The image cannot be downloaded"
                              : "Save to gallery",
                        ),
                      ),
                    );
                  },
                ),
                DropdownMenuItem<String>(
                  value: 'delete',
                  onTap: widget.onTapPageViewDelete,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.delete),
                      Text('Delete'),
                      Text(''),
                    ],
                  ),
                ),
              ],
              onChanged: (String? value) {},
            ),
          ],
        ),
        body: widget.imagePicker == null &&
                widget.image == null &&
                widget.imageNetwork == null &&
                widget.listImageNetwork != null
            ?
            // ignore: unnecessary_null_comparison
            widget.listImageNetwork != null
                ? PageView.builder(
                    reverse: true,
                    controller: _pageController,
                    itemCount: sortedListImage.length,
                    itemBuilder: (context, index) {
                      imageIndex = widget.listImageNetwork!.indexOf(
                        sortedListImage[index],
                      );
                      if (index <= sortedListImage.length) {
                        return Image.network(
                          sortedListImage[index],
                          width: size.width,
                          height: size.height,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return Container(); // یک ویجت خالی به عنوان fallback
                      }
                    },
                  )
                : Center(
                    child: widget.widgetLoadingPageView ??
                        const CircularProgressIndicator(),
                  )
            : PageView(
                controller: pageController,
                children: [
                  if (widget.imagePicker != null)
                    Image.file(
                      widget.imagePicker!,
                      width: size.width,
                      height: size.height,
                      fit: BoxFit.cover,
                    ),
                  if (widget.imageNetwork != null)
                    Image.network(
                      widget.imageNetwork!,
                      width: size.width,
                      height: size.height,
                      fit: BoxFit.cover,
                    ),
                  if (widget.image != null)
                    Image.asset(
                      widget.image!,
                      width: size.width,
                      height: size.height,
                      fit: BoxFit.cover,
                    )
                ],
              ),
      ),
    );
  }
}
