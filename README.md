This is a complete avatar package that you can use for your profile and avatar.

If you want to have the same avatar without crop, use this package: [avatar_better_pro](https://pub.dev/packages/avatar_better_pro)

## Features

**Features:**  

✔️ Initial Text: Displaying initial text for avatars or placeholders.  
✔️ Random Colors: Generating random colors for various elements.  
✔️ Random Linear Gradient: Generating random linear gradient colors.
✔️ Avatar Profile: Creating avatars for profiles or user representation.
✔️ Border Avatar: create a border around the avatar .
✔️ gradient Width Border: Create a gradient color for the borders .
✔️ Use ImageAssets .
✔️ Use ImageNetwork .
✔️ All Platfoem cropper .

![Capture1](https://github.com/SwanFlutter/flutter_avatars/assets/151648897/9cb4f63a-5b2d-4d58-b820-de9b080ddaaf) ![Capture2](https://github.com/SwanFlutter/flutter_avatars/assets/151648897/21aebfdd-a39a-46e7-bf2b-7b7c2e990891)

![Capture3](https://github.com/SwanFlutter/flutter_avatars/assets/151648897/8990ce91-bebe-461b-9aff-291a3a1a0a90)

![CaptureWeb](https://github.com/SwanFlutter/avatar_better/assets/151648897/25948b33-eaeb-4aa8-bc25-d8361a604dca)
![CaptureAvatar](https://github.com/SwanFlutter/avatar_better/assets/151648897/abff37b2-fc3b-448d-9563-cc11126c4cd5)

![Capture](https://github.com/user-attachments/assets/38d6a92f-1a79-4bee-b062-2404a33f638e)




## Getting started

```yaml
dependencies:
  avatar_better: ^0.0.9+1
```

## How to use

```dart
import 'package:avatar_better/avatar_better.dart';

```

## How to install

### Android

- To request permissions from the user, you can use the following code: AndroidManifest.xml.

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

<!-- For Android 10 and above, to access external storage -->
<uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION" />

<!-- For Android 12 and above -->
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" tools:ignore="ScopedStorage"/>


```


- For Android versions 33 and above (Android 13):

```xml

<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"/>

```

- Camera and internet access.

```xml

<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />

```

- Add this line code to application AndroidManifest.xml

```xml
android:requestLegacyExternalStorage="true"
```

```xml
<application
        android:label="avaterbetter"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:requestLegacyExternalStorage="true">
```

- Add UCropActivity into your AndroidManifest.xml

````xml
<activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
````

```xml
<queries>
    <intent>
        <action android:name="android.intent.action.GET_CONTENT" />
    </intent>
</queries>

```

### iOS

```xml
     <key>NSPhotoLibraryUsageDescription</key>
    <string>We need access to your photo library to select images for editing.</string>
    <key>NSCameraUsageDescription</key>
    <string>We need access to your camera to take photos for editing.</string>

    <key>NSPhotoLibraryUsageDescription</key>
    <string>App needs access to your photo library to read images.</string>

    <key>NSMicrophoneUsageDescription</key>
    <string>App needs access to the microphone to record audio.</string>

    <key>NSPhotoLibraryAddUsageDescription</key>
    <string>App needs access to your photo library to save images and videos.</string>



```

#### macOS installation

Since the macOS implementation uses `file_selector`, you will need to
add a filesystem access
[entitlement](https://docs.flutter.dev/platform-integration/macos/building#entitlements-and-the-app-sandbox):
```xml
  <key>com.apple.security.files.user-selected.read-only</key>
  <true/>
```

### Web
- Add following codes inside `<head>` tag in file `web/index.html`:

```html

<head>
    ....

    <!-- cropperjs -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js"></script>

    ....
</head>


```

## example

```dart
 Avatar(
    text: "Mic",
  radius: 50,
  showPageViewOnTap: true,
   itemsBuilderDropdownMenuItem: (index) {
     return [];
    },
     profileImageViewerOptions: ProfileImageViewerOptions(
      fitBackgroundImage: BoxFit.fitHeight,
      ),
     imageNetwork:
             "https://platinumlist.net/guide/wp-content/uploads/2023/03/IMG-worlds-of-adventure.webp",
   ),
```

```dart
Avatar.profile(
     text: "Mic",
      radius: 50,
    bottomSheetStyles: BottomSheetStyles(
  backgroundColor: Colors.red,
   elevation: 2,
  middleText: 'OR',
 middleTextStyle: const TextStyle(color: Colors.white)),
onPickerChange: () {},
 onPickerChangeWeb: (file) { },
 optionsCrop: OptionsCrop(),
  ),                   
```


## Additional information

If you have any issues, questions, or suggestions related to this package, please feel free to contact us at [swan.dev1993@gmail.com](mailto:swan.dev1993@gmail.com). We welcome your feedback and will do our best to address any problems or provide assistance.
For more information about this package, you can also visit our [GitHub repository](https://github.com/SwanFlutter/avatar_better) where you can find additional resources, contribute to the package's development, and file issues or bug reports. We appreciate your contributions and feedback, and we aim to make this package as useful as possible for our users.
Thank you for using our package, and we look forward to hearing from you!
