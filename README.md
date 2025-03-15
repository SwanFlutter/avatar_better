
# Avatar Better

A complete Flutter package for implementing customizable avatars and profile images with various styling options and interactive features.

![avatar3](https://github.com/user-attachments/assets/6187c133-cd0b-4056-83ac-4c0de47a21e1)

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


![Capture](https://github.com/user-attachments/assets/ac2d54f4-562b-4ef5-bce6-62cd196c9877)

![avatar2](https://github.com/user-attachments/assets/6aa52c2f-cacb-419f-b33e-1ba0da30c454)![avatar1](https://github.com/user-attachments/assets/13031a8f-1e5f-489c-98a9-720046a9ce8d)

![avatar](https://github.com/user-attachments/assets/42da29bc-a1bf-433b-a78d-65032c2971aa)![avatar3](https://github.com/user-attachments/assets/6187c133-cd0b-4056-83ac-4c0de47a21e1)


## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  avatar_better: ^0.0.9+5
```

Then run:

```
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

| Property | Type | Description |
|----------|------|-------------|
| `text` | `String` | The text to display as initials when no image is available |
| `radius` | `double` | The radius of the avatar (default: 35) |
| `widthBorder` | `double` | Width of the avatar border (default: 5.0) |
| `isBorderAvatar` | `bool` | Whether to show a border around the avatar |
| `image` | `String` | Path to a local asset image |
| `imageNetwork` | `String` | URL of a network image |
| `listImageNetwork` | `List<String>` | List of network image URLs for PageView |
| `backgroundColor` | `Color` | Background color of the avatar |
| `gradientBackgroundColor` | `Gradient` | Gradient background for the avatar |
| `gradientWidthBorder` | `Gradient` | Gradient for the avatar border |
| `randomColor` | `bool` | Generate random color based on text |
| `randomGradient` | `bool` | Generate random gradient based on text |
| `style` | `TextStyle` | Style for the text initials |
| `elevation` | `double` | Shadow elevation for the avatar |
| `shadowColor` | `Color` | Color of the shadow |
| `onTapAvatar` | `Function()` | Callback when avatar is tapped |
| `showPageViewOnTap` | `bool` | Show PageView when avatar is tapped |
| `profileImageViewerOptions` | `ProfileImageViewerOptions` | Options for the profile image viewer |
| `child` | `Widget` | Custom child widget to display inside the avatar |

### ProfileImageViewerOptions Properties

| Property | Type | Description |
|----------|------|-------------|
| `backgroundColorPageViewAppBar` | `Color` | Background color of the PageView app bar |
| `backBottomColorPageView` | `Color` | Background color of the PageView bottom bar |
| `backgroundColorDropdownMenuItem` | `Color` | Background color of dropdown menu items |
| `iconColorDropdownMenuItem` | `Color` | Icon color in dropdown menu items |
| `widgetLoadingPageView` | `Widget` | Custom loading widget for PageView |
| `fitBackgroundImage` | `BoxFit` | How to fit the image in PageView |

### BottomSheetStyles Properties

| Property | Type | Description |
|----------|------|-------------|
| `backgroundColor` | `Color` | Background color of the bottom sheet |
| `elevation` | `double` | Elevation of the bottom sheet |
| `middleText` | `String` | Text displayed between options |
| `middleTextStyle` | `TextStyle` | Style for the middle text |

### OptionsCrop Properties

Customize image cropping behavior with the `OptionsCrop` class. See the `image_cropper` package documentation for details.

## Platform Setup

### Android

Add the following permissions to your `AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          xmlns:tools="http://schemas.android.com/tools">

    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    
    <!-- For Android 10 and above -->
    <uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION" />
    
    <!-- For Android 12 and above -->
    <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" tools:ignore="ScopedStorage"/>
    
    <!-- For Android 13 and above -->
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
    <uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>
    <uses-permission android:name="android.permission.READ_MEDIA_AUDIO"/>
```

Add this to your application tag:

```xml
<application
    android:requestLegacyExternalStorage="true"
    ...>
```

Add UCropActivity to your AndroidManifest.xml:

```xml
<activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
```

Add these queries:

```xml
<queries>
    <intent>
        <action android:name="android.intent.action.GET_CONTENT" />
    </intent>
</queries>
```

### iOS

Add these keys to your `Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to select images for editing.</string>

<key>NSCameraUsageDescription</key>
<string>We need access to your camera to take photos for editing.</string>

<key>NSMicrophoneUsageDescription</key>
<string>App needs access to the microphone to record audio.</string>

<key>NSPhotoLibraryAddUsageDescription</key>
<string>App needs access to your photo library to save images and videos.</string>
```

### macOS

Add this entitlement to enable file selection:

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


