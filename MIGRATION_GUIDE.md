# Migration Guide - Avatar Better v0.1.4

## Overview

Version 0.1.4 introduces a **BREAKING CHANGE** by replacing multiple image picker and cropper packages with a unified `picker_image_cropper` package. This change provides better cross-platform compatibility, improved performance, and a more modern UI.

## What Changed

### Removed Dependencies
- `image_cropper: ^9.0.0`
- `image_picker: ^1.1.2`
- `image_cropping: ^0.0.15`

### Added Dependencies
- `picker_image_cropper` (from GitHub)

## Updated Classes

### OptionsCrop
The `OptionsCrop` class has been completely redesigned to work with the new package:

#### Before (v0.1.3)
```dart
OptionsCrop(
  cropStyle: CropStyle.circle,
  toolbarColorCrop: Colors.white,
  toolbarWidgetColorCrop: Colors.deepPurpleAccent,
  initAspectRatioCrop: CropAspectRatioPreset.square,
  webPresentStyle: WebPresentStyle.page,
)
```

#### After (v0.1.4)
```dart
OptionsCrop(
  cropperTheme: CropperTheme.light,
  aspectRatio: CropAspectRatio.square(),
  overlayType: CropOverlayType.circle,
  outputType: OutputType.both,
)
```

### New Properties Available

| Property | Type | Description |
|----------|------|-------------|
| `cropperTheme` | `CropperTheme` | Theme for the cropper UI (light, dark, blue) |
| `aspectRatio` | `CropAspectRatio` | Aspect ratio for cropping (square, free, etc.) |
| `overlayType` | `CropOverlayType` | Shape of crop overlay (rectangle, circle) |
| `outputType` | `OutputType` | Output format (bytes, file, both) |
| `showGrid` | `bool` | Whether to show grid in crop area |
| `maxScale` | `double` | Maximum zoom scale allowed |
| `useDraggableCropper` | `bool` | Enable draggable crop box |
| `maxImageSize` | `int` | Max image dimension for performance |

## Benefits of the New Package

1. **Unified API**: Single package for all platforms instead of multiple packages
2. **Better Performance**: Uses isolates for heavy image processing
3. **Modern UI**: Professional cropper interface with themes
4. **Cross-Platform**: Works consistently across Android, iOS, Web, Windows, macOS, and Linux
5. **Flexible Output**: Support for both bytes and file output types
6. **Optimized Loading**: Image precaching and efficient decoding

## Migration Steps

1. Update your `pubspec.yaml`:
   ```yaml
   dependencies:
     avatar_better: ^0.1.4
   ```

2. Update your `OptionsCrop` usage:
   ```dart
   // Old way
   OptionsCrop(
     cropStyle: CropStyle.circle,
     toolbarColorCrop: Colors.white,
   )
   
   // New way
   OptionsCrop(
     cropperTheme: CropperTheme.light,
     overlayType: CropOverlayType.circle,
   )
   ```

3. Run `flutter pub get` to update dependencies

## Backward Compatibility

The `OptionsCropWindMacLinux` class is kept for backward compatibility but now uses the unified package internally. However, we recommend migrating to the new `OptionsCrop` class for better consistency.

## Need Help?

If you encounter any issues during migration, please:
1. Check the updated documentation
2. Review the example code in the package
3. Open an issue on GitHub: https://github.com/SwanFlutter/avatar_better

## Example Usage

```dart
Avatar.profile(
  text: "John Doe",
  radius: 50,
  optionsCrop: OptionsCrop(
    cropperTheme: CropperTheme.dark,
    aspectRatio: CropAspectRatio.square(),
    overlayType: CropOverlayType.circle,
    outputType: OutputType.both,
    showGrid: true,
    maxScale: 3.0,
  ),
  onPickerChange: (file) {
    // Handle the selected file
  },
)
```