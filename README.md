
# Avatar Better

A complete Flutter package for implementing customizable avatars and profile images with various styling options and interactive features.

<img width="387" height="865" alt="1" src="https://github.com/user-attachments/assets/ef76f50b-9ab9-43ca-831a-d6c71bf174f3" />


## Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Basic Usage](#basic-usage)
  - [Simple Avatar](#simple-avatar)
  - [Avatar with Network Image](#avatar-with-network-image)
  - [Avatar with PageView on Tap](#avatar-with-pageview-on-tap)
  - [Profile Avatar with Image Picker](#profile-avatar-with-image-picker)
- [Advanced Usage](#advanced-usage)
  - [Custom Styling](#custom-styling)
  - [PageView with Custom Options](#pageview-with-custom-options)
  - [Profile with Image Picker and Custom Bottom Sheet](#profile-with-image-picker-and-custom-bottom-sheet)
- [Configuration](#configuration)
  - [Avatar Properties](#avatar-properties)
  - [ProfileImageViewerOptions Properties](#profileimagevieweroptions-properties)
  - [BottomSheetStyles Properties](#bottomsheetstyles-properties)
  - [OptionsCrop Properties](#optionscrop-properties)
- [Platform Setup](#platform-setup)
  - [Android](#android)
  - [iOS](#ios)
  - [macOS](#macos)
  - [Web](#web)
- [Related Packages](#related-packages)
- [Contact & Support](#contact--support)

## Features

✔️ **Initial Text Display** - Shows initials when no image is provided
✔️ **Random Colors** - Automatically generates colors based on text
✔️ **Random Linear Gradients** - Creates beautiful gradient backgrounds
✔️ **Border Support** - Add customizable borders around avatars
✔️ **Gradient Borders** - Apply gradient colors to avatar borders
✔️ **Multiple Image Sources** - Support for assets, network, and selected images
✔️ **Image Cropping** - Cross-platform image cropping functionality
✔️ **Interactive PageView** - View avatars in an interactive full-screen mode
✔️ **Platform Support** - Works on Android, iOS, Web, Windows, and macOS

## Screenshots

<img width="1263" height="681" alt="2" src="https://github.com/user-attachments/assets/7f59f68a-ac8f-4028-ad42-ee443c2a9ab8" />


![avatar2](https://github.com/user-attachments/assets/6aa52c2f-cacb-419f-b33e-1ba0da30c454)![avatar1](https://github.com/user-attachments/assets/13031a8f-1e5f-489c-98a9-720046a9ce8d)

![avatar](https://github.com/user-attachments/assets/42da29bc-a1bf-433b-a78d-65032c2971aa)

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  avatar_better: ^0.1.2
```

Then run:

```bash
flutter pub get
```

## Basic Usage

Import the package:

```dart
import 'package:avatar_better/avatar_better.dart';
```

### Simple Avatar

```dart
Avatar(
  text: "John Doe",
  radius: 35,
  randomColor: true,
)
```

### Avatar with Network Image

```dart
Avatar(
  text: "John Doe",
  radius: 50,
  imageNetwork: "https://example.com/profile.jpg",
)
```

### Avatar with PageView on Tap

```dart
Avatar(
  text: "John Doe",
  radius: 50,
  showPageViewOnTap: true,
  imageNetwork: "https://example.com/profile.jpg",
)
```

### Profile Avatar with Image Picker

```dart
Avatar.profile(
  text: "John Doe",
  radius: 50,
  onPickerChange: (file) {
    // Handle the selected file
  },
)
```

## Advanced Usage

### Custom Styling

```dart
Avatar(
  text: "John Doe",
  radius: 50,
  randomGradient: true,
  isBorderAvatar: true,
  widthBorder: 5.0,
  gradientWidthBorder: const LinearGradient(
    colors: [Colors.purple, Colors.blue],
  ),
  style: const TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
)
```

### PageView with Custom Options

```dart
Avatar(
  text: "John Doe",
  radius: 50,
  showPageViewOnTap: true,
  imageNetwork: "https://example.com/profile.jpg",
  profileImageViewerOptions: ProfileImageViewerOptions(
    fitBackgroundImage: BoxFit.cover,
    backgroundColorPageViewAppBar: Colors.black,
    backBottomColorPageView: Colors.white,
  ),
)
```

### Profile with Image Picker and Custom Bottom Sheet

```dart
Avatar.profile(
  text: "John Doe",
  radius: 50,
  bottomSheetStyles: BottomSheetStyles(
    backgroundColor: Colors.blue,
    elevation: 4,
    middleText: 'OR',
    middleTextStyle: const TextStyle(color: Colors.white),
  ),
  onPickerChange: (file) {
    // Handle the selected file
  },
  optionsCrop: OptionsCrop(
    // Customize cropping options
  ),
)
```

## Configuration

### Avatar Properties

| Property                      | Type                          | Description                                                      |
|-------------------------------|-------------------------------|------------------------------------------------------------------|
| `text`                        | `String`                      | The text to display as initials when no image is available       |
| `radius`                      | `double`                      | The radius of the avatar (default: 35)                           |
| `widthBorder`                 | `double`                      | Width of the avatar border (default: 5.0)                        |
| `isBorderAvatar`              | `bool`                        | Whether to show a border around the avatar                       |
| `image`                       | `String`                      | Path to a local asset image                                      |
| `imageNetwork`                | `String`                      | URL of a network image                                           |
| `listImageNetwork`            | `List<String>`                | List of network image URLs for PageView                          |
| `backgroundColor`             | `Color`                       | Background color of the avatar                                   |
| `gradientBackgroundColor`     | `Gradient`                    | Gradient background for the avatar                               |
| `gradientWidthBorder`         | `Gradient`                    | Gradient for the avatar border                                   |
| `randomColor`                 | `bool`                        | Generate random color based on text                              |
| `randomGradient`              | `bool`                        | Generate random gradient based on text                           |
| `style`                       | `TextStyle`                   | Style for the text initials                                      |
| `elevation`                   | `double`                      | Shadow elevation for the avatar                                  |
| `shadowColor`                 | `Color`                       | Color of the shadow                                              |
| `onTapAvatar`                 | `Function()`                  | Callback when avatar is tapped                                   |
| `showPageViewOnTap`           | `bool`                        | Show PageView when avatar is tapped                              |
| `profileImageViewerOptions`   | `ProfileImageViewerOptions`   | Options for the profile image viewer                             |
| `child`                       | `Widget`                      | Custom child widget to display inside the avatar                 |

### ProfileImageViewerOptions Properties

| Property                          | Type     | Description                                      |
|-----------------------------------|----------|--------------------------------------------------|
| `backgroundColorPageViewAppBar`   | `Color`  | Background color of the PageView app bar         |
| `backBottomColorPageView`         | `Color`  | Background color of the PageView bottom bar        |
| `backgroundColorDropdownMenuItem` | `Color`  | Background color of dropdown menu items          |
| `iconColorDropdownMenuItem`       | `Color`  | Icon color in dropdown menu items                |
| `widgetLoadingPageView`           | `Widget` | Custom loading widget for PageView               |
| `fitBackgroundImage`              | `BoxFit` | How to fit the image in PageView                 |

### BottomSheetStyles Properties

| Property          | Type        | Description                              |
|-------------------|-------------|------------------------------------------|
| `backgroundColor` | `Color`     | Background color of the bottom sheet     |
| `elevation`       | `double`    | Elevation of the bottom sheet            |
| `middleText`      | `String`    | Text displayed between options           |
| `middleTextStyle` | `TextStyle` | Style for the middle text                |

### OptionsCrop Properties

| Property              | Type                | Description                                      |
|-----------------------|---------------------|--------------------------------------------------|
| `cropperTheme`        | `CropperTheme`      | Theme for the cropper UI (light, dark, blue)    |
| `aspectRatio`         | `CropAspectRatio`   | Aspect ratio for cropping (square, free, etc.)  |
| `overlayType`         | `CropOverlayType`   | Shape of crop overlay (rectangle, circle)       |
| `outputType`          | `OutputType`        | Output format (bytes, file, both)               |
| `showGrid`            | `bool`              | Whether to show grid in crop area               |
| `maxScale`            | `double`            | Maximum zoom scale allowed                       |
| `useDraggableCropper` | `bool`              | Enable draggable crop box                       |
| `maxImageSize`        | `int`               | Max image dimension for performance              |

## Platform Setup

### Android

Add the following permissions to your `AndroidManifest.xml` file located at `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          xmlns:tools="http://schemas.android.com/tools">

    <uses-permission android:name="android.permission.INTERNET" />
    <!-- Add other permissions if needed by image_picker or other dependencies -->


    <application
        android:requestLegacyExternalStorage="true"
        ...>

        <activity
            android:name="com.yalantis.ucrop.UCropActivity"
            android:screenOrientation="portrait"
            android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
        
        <!-- Other activities, services, and receivers -->
    </application>

    <!-- For Android 11 (API level 30) and above, if you target SDK 30+ -->
    <!-- You might need to declare specific package visibility -->
    <queries>
        <!-- If you want to open camera -->
        <intent>
            <action android:name="android.media.action.IMAGE_CAPTURE" />
        </intent>
        <!-- If you want to open gallery -->
        <intent>
            <action android:name="android.intent.action.GET_CONTENT" />
            <data android:mimeType="image/*" />
        </intent>
        <intent>
            <action android:name="android.intent.action.PICK" />
            <data android:mimeType="image/*" />
        </intent>
    </queries>

</manifest>
```

**Note:** For Android 13 (API level 33) and above, `READ_EXTERNAL_STORAGE` and `WRITE_EXTERNAL_STORAGE` have been replaced by more granular permissions like `READ_MEDIA_IMAGES`, `READ_MEDIA_VIDEO`, and `READ_MEDIA_AUDIO`. Ensure you are using the correct permissions based on your `targetSdkVersion` and the types of files your app needs to access. The `image_picker` and `image_cropper` packages usually handle these, but it's good to be aware.

### iOS

Add the following keys to your `Info.plist` file located at `ios/Runner/Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to select images for your avatar.</string>
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to take photos for your avatar.</string>
<key>NSMicrophoneUsageDescription</key>
<string>This app does not require microphone access. (This key might be added by other plugins, include if necessary)</string> 
<key>NSPhotoLibraryAddUsageDescription</key>
<string>This app needs access to your photo library to save images.</string>
```

### macOS

Add this entitlement to your `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements` files to enable file selection:

```xml
<key>com.apple.security.files.user-selected.read-only</key>
<true/>
```

### Web

Add the following to the `<head>` section of your `web/index.html`:

```html
<!-- cropperjs -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js"></script>
```

## Related Packages

If you want a similar avatar package without cropping functionality, check out [avatar_better_pro](https://pub.dev/packages/avatar_better_pro).

## Contact & Support

If you have any issues, questions, or suggestions:
- Email: [swan.dev1993@gmail.com](mailto:swan.dev1993@gmail.com)
- GitHub: [https://github.com/SwanFlutter/avatar_better](https://github.com/SwanFlutter/avatar_better)

We welcome your feedback and contributions!


