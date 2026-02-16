
---


## 1.0.4


### **Exports & API Surface**
- Export BottomSheet configuration classes to public API:
  - `GalleryBottom`
  - `CameraButton`
- Export desktop crop options:
  - `OptionsCropWindMacLinux`

### **Bug Fixes**
- Fixed `CameraButton` and `GalleryBottom` identification error in example by adding exports.

---

## 1.0.3


### **Dependency Update: `path_provider` → `path_provider_master: ^1.0.0`**

- **No changes to the public API**: The package maintains full backward compatibility.
- **Enhanced functionality**: Access to public directories is now supported (as per the new package documentation).
- **Updated imports**: Replace imports with:
  ```dart
  import 'package:path_provider_master/path_provider_master.dart';
  ```
- **Verification steps**:
  - Run `flutter pub get` to update dependencies.
  - Validate project health with `flutter analyze` and ensure all tests pass.

---

---


## 1.0.2
* Fix null check operator used on a null value crash when text is null.
* Add validation to prevent both `randomColor` and `randomGradient` from being true simultaneously.
* Add validation to ensure `backgroundColor` cannot be set when random flags are active.
* Add validation to ensure `gradientBackgroundColor` cannot be set when random flags are active.
* Fix internal validation conflict between `Avatar.profile` and `Profile` widget.
* Remove unsafe null assertions (`!`) across all avatar widgets for better stability.

---


## 0.1.1
* Fix bug avatar profile border.

---

## 0.1.0
* Add new Feature.
* Add new Property `bottomSheetStyles`.
* Fix UI bottom sheet.

---

## 0.0.9
* Fix pub points.
* Add new property `iconSize`.
* Enhanced `OnPickerChange` typedef to support both `File` and `Uint8List` parameters.
* Maintained backward compatibility with `onPickerChangeWeb` property.
* Fixed text centering issue in avatar widgets.
* Updated dependencies (`permission_handler`, `image_picker`).
* Added `dart:typed_data` import for `Uint8List` support.
* Improved cross-platform image handling.
* Update UI bottomSheet.
* Update Flutter SDK.

---

## 0.0.8
* Fix bug avatar.

---

## 0.0.7
* Add two new features.

---

## 0.0.6
* Add new feature.

---

## 0.0.5
* Fix pub points.
* Update package.
* Add new feature.

---

## 0.0.4
* Fix bug.

---

## 0.0.1
* TODO: Describe initial release.
