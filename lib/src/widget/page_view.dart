// ignore_for_file: must_be_immutable, unrelated_type_equality_checks, use_build_context_synchronously, unnecessary_null_comparison, unused_local_variable

import 'dart:io';

import 'package:avatar_better/avatar_better.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zoom_hover_pinch_image/zoom_hover_pinch_image.dart';

class PageViewAvatar extends StatefulWidget {
  ///
  ///
  /// Represents a list of network images that can be displayed.
  ///
  final List<String>? listImageNetwork;

  /// Represents a local image file path.
  final String? image;

  /// Represents a network image URL.
  late String? imageNetwork;

  /// Represents an image selected from the device's storage.
  final File? imagePicker;

  /// Represents the name of the page view.
  final String? namePageview;

  /// Represents the text style for the page view's name.
  final TextStyle? stylePageViewTextName;

  /// Represents the background color of the app bar in the page view.
  final Color? backgroundColorPageViewAppBar;

  /// Represents the widget to be displayed while loading the page view.
  final Widget? widgetLoadingPageView;

  /// Represents the background color of dropdown menu items.
  final Color? backgroundColorDropdownMenuItem;

  /// Represents the icon color of dropdown menu items.
  final Color? iconColorDropdownMenuItem;

  /// Represents the background color of the bottom section.
  final Color? backBottomColor;

  /// Represents the fit of the background image.
  final BoxFit? fitBackgroundImage;

  final Avatar widget;

  PageViewAvatar({
    super.key,
    required this.imagePicker,
    required this.widget,
    this.image,
    this.imageNetwork,
    this.listImageNetwork,
    this.namePageview,
    this.stylePageViewTextName = const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 22.0,
    ),
    this.backgroundColorPageViewAppBar = Colors.white,
    this.widgetLoadingPageView,
    this.backgroundColorDropdownMenuItem = Colors.white,
    this.iconColorDropdownMenuItem = Colors.black,
    this.backBottomColor = Colors.black,
    this.fitBackgroundImage = BoxFit.fitHeight,
  });

  @override
  State<PageViewAvatar> createState() => _PageViewAvatarState();
}

class _PageViewAvatarState extends State<PageViewAvatar> {
  late PageController _pageController;
  final pageController = PageController();
  late int imageIndex;
  late int indexForPageView = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    var sortedListImageNetwork = List<String>.from(
      widget.listImageNetwork ?? [],
    );
    sortedListImageNetwork.sort((a, b) => a.length.compareTo(b.length));

    var sortedListImage = List<String>.from(widget.listImageNetwork ?? []);
    var lastImageIndex = sortedListImageNetwork.length - 1;
    for (var i = lastImageIndex; i >= 0; i--) {
      sortedListImage.add(sortedListImageNetwork[i]);
    }

    return Scaffold(
      backgroundColor: theme.primaryColorLight,
      appBar: AppBar(
        leading: BackButton(color: widget.backBottomColor),
        title: Text(
          widget.namePageview != null ? widget.namePageview! : "",
          style: widget.stylePageViewTextName,
        ),
        backgroundColor:
            widget.backgroundColorPageViewAppBar ?? theme.primaryColorLight,
        actions: [
          DropdownButton(
            dropdownColor:
                widget.backgroundColorDropdownMenuItem ??
                Theme.of(context).primaryColorLight,
            icon: Icon(
              Icons.more_vert,
              color: widget.iconColorDropdownMenuItem,
            ),
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
                  saveImage(context);
                },
              ),
              ...?widget.widget.itemsBuilderDropdownMenuItem!(indexForPageView),
            ],
            onChanged: (String? value) {},
          ),
        ],
      ),
      body:
          widget.imagePicker == null &&
              widget.image == null &&
              widget.imageNetwork == null &&
              widget.listImageNetwork != null
          ? widget.listImageNetwork != null
                ? Zoom.zoomOnTap(
                    zoomedScale: 3.0,
                    doubleTapZoom: true,
                    clipBehavior: true,
                    width: size.width,
                    height: size.height,
                    child: PageView.builder(
                      reverse: true,
                      controller: _pageController,
                      itemCount: sortedListImage.length,
                      itemBuilder: (context, index) {
                        indexForPageView = index;
                        imageIndex = widget.listImageNetwork!.indexOf(
                          sortedListImage[index],
                        );
                        if (index <= sortedListImage.length) {
                          return Image.network(
                            sortedListImage[index],
                            width: size.width,
                            height: size.height,
                            fit: widget.fitBackgroundImage,
                          );
                        } else {
                          return Container(); // یک ویجت خالی به عنوان fallback
                        }
                      },
                    ),
                  )
                : Center(
                    child:
                        widget.widgetLoadingPageView ??
                        const CircularProgressIndicator(),
                  )
          : Zoom.zoomOnTap(
              zoomedScale: 3.0,
              doubleTapZoom: true,
              clipBehavior: true,
              width: size.width,
              height: size.height,
              child: PageView(
                controller: pageController,
                children: [
                  if (widget.imagePicker != null)
                    Image.file(
                      widget.imagePicker!,
                      width: size.width,
                      height: size.height,
                      fit: widget.fitBackgroundImage,
                    ),
                  if (widget.imageNetwork != null)
                    Image.network(
                      widget.imageNetwork!,
                      width: size.width,
                      height: size.height,
                      fit: widget.fitBackgroundImage,
                    ),
                  if (widget.image != null)
                    Image.asset(
                      widget.image!,
                      width: size.width,
                      height: size.height,
                      fit: widget.fitBackgroundImage,
                    ),
                ],
              ),
            ),
    );
  }

  void showSnackBar(BuildContext context, bool isSaved) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(15.0),
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        content: Text(
          isSaved ? 'Image saved successfully!' : 'Failed to save image.',
        ),
      ),
    );
  }

  void saveImage(BuildContext context) async {
    if (widget.imagePicker != null) {
      bool isSaved = false;

      if (kIsWeb || Platform.isWindows || Platform.isLinux) {
        isSaved = await FlutterSaver.saveImageWindowsWeb(
          fileImage: widget.imagePicker!,
        );
      } else if (Platform.isAndroid) {
        isSaved = await FlutterSaver.saveImageAndroid(
          fileImage: widget.imagePicker!,
        );
      } else if (Platform.isIOS) {
        isSaved = await FlutterSaver.saveImageIos(
          fileImage: widget.imagePicker!,
        );
      } else if (Platform.isMacOS) {
        isSaved = await FlutterSaver.saveImageMacOs(
          fileImage: widget.imagePicker!,
        );
      } else {
        debugPrint('Failed to save image. Unsupported platform.');
      }

      showSnackBar(context, isSaved);
    } else if (widget.imageNetwork != null) {
      bool isSaved = false;

      if (kIsWeb || Platform.isWindows || Platform.isLinux) {
        isSaved = await FlutterSaver.saveNetworkFileWindowsWeb(
          link: widget.imageNetwork!,
        );
      } else if (Platform.isAndroid) {
        isSaved = await FlutterSaver.saveNetworkFileAndroid(
          link: widget.imageNetwork!,
        );
      } else if (Platform.isIOS) {
        isSaved = await FlutterSaver.saveNetworkFileIos(
          link: widget.imageNetwork!,
        );
      } else if (Platform.isMacOS) {
        isSaved = await FlutterSaver.saveNetworkFileMac(
          link: widget.imageNetwork!,
        );
      } else {
        debugPrint('Failed to save image. Unsupported platform.');
      }

      showSnackBar(context, isSaved);
    } else if (widget.listImageNetwork != null &&
        widget.listImageNetwork!.isNotEmpty) {
      bool isSaved = false;

      if (kIsWeb || Platform.isWindows) {
        isSaved = await FlutterSaver.saveNetworkFileWindowsWeb(
          link: widget.listImageNetwork!.last,
        );
      } else if (Platform.isLinux) {
        isSaved = await FlutterSaver.saveNetworkFileLinux(
          link: widget.listImageNetwork!.last,
        );
      } else if (Platform.isAndroid) {
        isSaved = await FlutterSaver.saveNetworkFileAndroid(
          link: widget.listImageNetwork!.last,
        );
      } else if (Platform.isIOS) {
        isSaved = await FlutterSaver.saveNetworkFileIos(
          link: widget.listImageNetwork!.last,
        );
      } else if (Platform.isMacOS) {
        isSaved = await FlutterSaver.saveNetworkFileMac(
          link: widget.listImageNetwork!.last,
        );
      } else {
        debugPrint('Failed to save image. Unsupported platform.');
      }

      showSnackBar(context, isSaved);
    } else {
      debugPrint('Failed to save image. Unsupported platform.');
    }
  }
}
