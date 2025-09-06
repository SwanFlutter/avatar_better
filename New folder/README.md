# Modern Image Cropper

A modern, high-performance Flutter package for picking and cropping images. Built with a professional UI, extensive customization options, and a focus on performance and developer experience.

<p align="center">
  <img src="https://github.com/user-attachments/assets/be2b3566-cb0d-4b63-a089-2a53cdef7e3b" alt="Modern Image Cropper Preview" width="1200">
</p>

## ✨ Features

- ✅ **High-Performance Cropping**: Uses isolates (`compute`) for heavy image processing to prevent UI lag.
- ✅ **Optimized Loading**: Implements image precaching and efficient decoding for faster load times.
- ✅ **Flexible Image Sources**: Pick from the gallery or capture directly from the camera.
- ✅ **Rich Customization**:
    - **Themes**: Pre-built themes (`dark`, `light`, `blue`) and support for custom themes.
    - **Aspect Ratios**: Multiple ratios (`free`, `square`, `4:3`, `16:9`, etc.).
    - **Crop Shapes**: Rectangle and circle overlays.
- ✅ **Intuitive UI**:
    - Draggable and resizable crop box.
    - Interactive controls for rotation, scaling, and resetting.
    - Optional grid overlay for precise alignment.
- ✅ **Dual Output Types**: Get the cropped image as `Uint8List`, a `File`, or both.
- ✅ **Callback Support**: New callback-based methods for handling results with `OnImagePickerCompleted`, `OnFilePickerCompleted`, and `OnBytesPickerCompleted`.
- ✅ **Internationalization Support**: Customizable text labels with built-in support for multiple languages (English, Persian, Arabic, Spanish, French, German).
- ✅ **Cross-Platform**: Works seamlessly on Android, iOS, and other Flutter-supported platforms.

## 🚀 Getting Started

### Installation

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  picker_image_cropper: ^1.0.0 # Replace with the latest version
```

Instal for git

```yaml
picker_image_cropper:
    git:
      url: https://github.com/SwanFlutter/picker_image_cropper.git

```

Then, run `flutter pub get`.

### Basic Usage

Import the package and use the static methods to pick and crop an image.

```dart
import 'package:picker_image_cropper/picker_image_cropper.dart';

Future<void> _pickAndCropImage() async {
  final result = await ImagePickerCropper.pickAndCrop(
    context: context,
    source: ImageSource.gallery,
  );

  if (result != null) {
    setState(() {
      // The result is a CropResult object
      _croppedImageBytes = result.bytes;
    });
  }
}
```

## 📚 Advanced Usage

### Pick from Camera

Capture a photo and immediately open the cropper.

```dart
final result = await ImagePickerCropper.pickAndCrop(
  context: context,
  source: ImageSource.camera,
  cropperTheme: CropperTheme.dark,
  aspectRatio: CropAspectRatio.square(),
  overlayType: CropOverlayType.circle,
  labels: CropperLabels.persian(), // Persian interface
);
```

### Crop an Existing Image

If you already have an image file, you can pass it directly to the cropper.

```dart
import 'dart:io';

final imageFile = File('path/to/your/image.jpg');

final result = await ImagePickerCropper.cropImage(
  context: context,
  imageFile: imageFile,
  theme: CropperTheme.light,
  labels: CropperLabels.arabic(), // Arabic interface
);
```

### Using Callback Methods (New!)

For better control and handling of results, you can use the new callback-based methods:

```dart
// Pick and crop with callbacks
await ImagePickerCropper.pickAndCropWithCallback(
  context: context,
  fromCamera: false, // true for camera, false for gallery
  onCompleted: (file, bytes) {
    // Called when both file and bytes are available
    print('File: $file');
    print('Bytes length: ${bytes?.length}');
  },
  onFileCompleted: (file) {
    // Called when file is ready
    print('File ready: ${file.path}');
  },
  onBytesCompleted: (bytes) {
    // Called when bytes are ready
    print('Bytes ready: ${bytes.length} bytes');
  },
);
```

```dart
// Crop existing image with callbacks
await ImagePickerCropper.cropImageWithCallback(
  context: context,
  imageFile: myImageFile,
  onCompleted: (file, bytes) {
    // Handle the cropped result
    setState(() {
      _croppedFile = file;
      _croppedBytes = bytes;
    });
  },
);
```

### Callback Types

The package provides three callback types:

- `OnImagePickerCompleted`: `void Function(File? file, Uint8List? bytes)` - Receives both file and bytes
- `OnFilePickerCompleted`: `void Function(File file)` - Receives only the file
- `OnBytesPickerCompleted`: `void Function(Uint8List bytes)` - Receives only the bytes

### Internationalization Support (New!)

Customize all text labels in the cropper interface to support different languages:

```dart
// Using built-in language presets
await ImagePickerCropper.pickAndCrop(
  context: context,
  labels: CropperLabels.persian(), // Persian labels
);

// Or use other built-in languages
labels: CropperLabels.arabic(),   // Arabic
labels: CropperLabels.spanish(),  // Spanish
labels: CropperLabels.french(),   // French
labels: CropperLabels.german(),   // German

// Custom labels
labels: CropperLabels(
  cropImageTitle: 'تصویر را برش دهید',
  cropButtonText: 'برش',
  ratioText: 'نسبت:',
  shapeText: 'شکل:',
  gridButtonText: 'شبکه',
  rotateButtonText: 'چرخش',
  resetButtonText: 'بازنشانی',
  errorLoadingImage: 'خطا در بارگذاری تصویر',
  failedToLoadImage: 'بارگذاری تصویر ناموفق بود',
  loadingImage: 'در حال بارگذاری تصویر...',
),
```

#### Available Language Presets

- `CropperLabels()` - English (default)
- `CropperLabels.persian()` - Persian/Farsi
- `CropperLabels.arabic()` - Arabic
- `CropperLabels.spanish()` - Spanish
- `CropperLabels.french()` - French
- `CropperLabels.german()` - German

### Working with `CropResult`

The cropping methods return a `CropResult` object, which provides the output in multiple formats.

```dart
final result = await ImagePickerCropper.pickAndCrop(
  context: context,
  outputType: OutputType.both, // Get both bytes and a file
);

if (result != null) {
  // 1. Get image as bytes
  if (result.hasBytes) {
    final bytes = result.bytes; // Uint8List
    print('Image size: ${result.bytesSizeInKB} KB');
  }
  
  // 2. Get image as a file
  if (result.hasFile) {
    final file = result.file; // File object
    final path = result.filePath; // String path
    print('Image saved to: $path');
  }
}
```

- `OutputType.bytes`: (Default) Returns `Uint8List`.
- `OutputType.file`: Saves the cropped image to a temporary file and returns a `File` object.
- `OutputType.both`: Returns both `Uint8List` and a `File`.

## 🎨 Customization

### Cropper Themes

Choose from pre-built themes or create your own.

```dart
// Use a pre-built theme
final result = await ImagePickerCropper.pickAndCrop(
  context: context,
  cropperTheme: CropperTheme.blue,
);

// Create a custom theme
final myTheme = CropperTheme(
  backgroundColor: Colors.grey[900]!,
  appBarColor: Colors.black,
  controlButtonColor: Colors.white,
  // ... and many more properties
);

final result = await ImagePickerCropper.pickAndCrop(
  context: context,
  cropperTheme: myTheme,
);
```

### Aspect Ratios

Control the crop box aspect ratio.

```dart
CropAspectRatio.free()       // No constraints
CropAspectRatio.square()     // 1:1
CropAspectRatio.standard()   // 4:3
CropAspectRatio.widescreen() // 16:9
```

### Overlay Types

Choose between a rectangle or circle crop area.

```dart
CropOverlayType.rectangle // Default
CropOverlayType.circle    // For circular profile pictures
```

### All Parameters

#### Parameters for `pickAndCrop`:

| Parameter | Type | Description |
|---|---|---|
| `context` | `BuildContext` | **Required.** The build context. |
| `source` | `ImageSource` | **Required.** `ImageSource.gallery` or `ImageSource.camera`. |
| `outputType` | `OutputType` | The desired output format (`bytes`, `file`, `both`). |
| `cropperTheme` | `CropperTheme` | The theme for the cropper UI. |
| `aspectRatio` | `CropAspectRatio` | The aspect ratio of the crop box. |
| `overlayType` | `CropOverlayType` | The shape of the crop overlay. |
| `showGrid` | `bool` | Whether to show a grid inside the crop box. |
| `maxScale` | `double` | The maximum zoom scale allowed. |
| `useDraggableCropper` | `bool` | Enables a draggable crop box. |
| `labels` | `CropperLabels` | Text labels for internationalization support. |
| `maxImageSize` | `int` | The maximum dimension (width or height) to which large images are resized before cropping to improve performance. Defaults to `1920`. |

#### Parameters for `pickAndCropWithCallback`:

| Parameter | Type | Description |
|---|---|---|
| `context` | `BuildContext` | **Required.** The build context. |
| `fromCamera` | `bool` | **Required.** `true` for camera, `false` for gallery. |
| `onCompleted` | `OnImagePickerCompleted?` | Callback when both file and bytes are available. |
| `onFileCompleted` | `OnFilePickerCompleted?` | Callback when file is ready. |
| `onBytesCompleted` | `OnBytesPickerCompleted?` | Callback when bytes are ready. |
| `theme` | `CropperTheme?` | The theme for the cropper UI. |
| `aspectRatio` | `CropAspectRatio?` | The aspect ratio of the crop box. |
| `labels` | `CropperLabels` | Text labels for internationalization support. |

#### Parameters for `cropImageWithCallback`:

| Parameter | Type | Description |
|---|---|---|
| `context` | `BuildContext` | **Required.** The build context. |
| `imageFile` | `File` | **Required.** The image file to crop. |
| `onCompleted` | `OnImagePickerCompleted?` | Callback when both file and bytes are available. |
| `onFileCompleted` | `OnFilePickerCompleted?` | Callback when file is ready. |
| `onBytesCompleted` | `OnBytesPickerCompleted?` | Callback when bytes are ready. |
| `theme` | `CropperTheme?` | The theme for the cropper UI. |
| `aspectRatio` | `CropAspectRatio?` | The aspect ratio of the crop box. |
| `labels` | `CropperLabels` | Text labels for internationalization support. |

## 🤝 Contributing

Contributions are welcome! If you find a bug or have a feature request, please open an issue. If you want to contribute code, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b my-feature-branch`).
3. Make your changes and commit them (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin my-feature-branch`).
5. Open a pull request.




