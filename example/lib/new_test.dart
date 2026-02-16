import 'package:avatar_better/avatar_better.dart';
import 'package:flutter/material.dart';

class NewTest extends StatelessWidget {
  const NewTest({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NewTest')),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Avatar(
              text: 'NewTest',
              radius: 45,
              randomColor: true,
              randomGradient: false,
            ),
            SizedBox(height: 20),
            Avatar.profile(
              text: 'NewTest',
              radius: 45,
              randomColor: true,
              randomGradient: false,
              backgroundColor: Colors.white,
              backgroundColorCamera: Colors.blue,
              child: Text('NewTest'),
              gradientBackgroundColor: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              onPickerChange: (file) {},

              onPickerChangeWeb: (file) {},

              widthBorder: 5,
              elevation: 5,
              gradientWidthBorder: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              image: 'assets/images/avatar.png',
              imageNetwork: 'https://picsum.photos/200',
              isBorderAvatar: true,
              mixColorForGradient: true,
              optionsCrop: OptionsCrop(),
              shadowColor: Colors.blue,
              style: TextStyle(color: Colors.white),
              useMaterialColorForGradient: true,
              icon: Icons.add_a_photo,
              iconColor: Colors.white,
              bottomSheetStyles: BottomSheetStyles(
                cameraButton: CameraButton(
                  style: null,
                  color: Colors.blue,
                  text: '',
                  icon: null,
                ),
                galleryButton: GalleryBottom(
                  style: null,
                  color: Colors.blue,
                  text: '',
                  icon: null,
                ),

                backgroundColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                middleText: '',
                middleTextStyle: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
