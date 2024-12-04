// ignore_for_file: unrelated_type_equality_checks, depend_on_referenced_packages

/// Handles permissions based on the Android version.
///
/// Requests different permissions depending on the Android version.
///
/*
Future<void> handlePermissions() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    int sdkInt = androidInfo.version.sdkInt;

    if (sdkInt >= 33) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.photos,
        Permission.videos,
        Permission.audio,
      ].request();

      if (statuses[Permission.storage]!.isGranted &&
          statuses[Permission.photos]!.isGranted &&
          statuses[Permission.videos]!.isGranted &&
          statuses[Permission.audio]!.isGranted) {
        // All permissions granted
      } else {
        // At least one permission is denied
        if (statuses == PermissionStatus.denied) {
          openAppSettings();
        }
      }
    } else if (sdkInt >= 29) {
      // درخواست دسترسی برای دوربین
      var cameraStatus = await Permission.camera.status;
      if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }

      // درخواست دسترسی برای ضبط صدا
      var audioStatus = await Permission.audio.status;
      if (!audioStatus.isGranted) {
        await Permission.audio.request();
      }

      // درخواست دسترسی برای خواندن و نوشتن در حافظه
      var storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        await Permission.storage.request();
      }

      // درخواست دسترسی برای Android 10 و بالاتر برای مدیریت رسانه‌ها
      if (await Permission.manageExternalStorage.isRestricted ||
          await Permission.manageExternalStorage.isDenied) {
        await Permission.manageExternalStorage.request();
      } else {
        // At least one permission is denied
        if (cameraStatus == PermissionStatus.denied ||
            audioStatus == PermissionStatus.denied ||
            storageStatus == PermissionStatus.denied) {
          openAppSettings();
        }
      }
    } else {
      // درخواست دسترسی برای دوربین
      var cameraStatus = await Permission.camera.status;
      if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }

      // درخواست دسترسی برای ضبط صدا
      var micStatus = await Permission.audio.status;
      if (!micStatus.isGranted) {
        await Permission.audio.request();
      }

      // درخواست دسترسی برای خواندن و نوشتن در حافظه
      var storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        await Permission.storage.request();
      }
    }
  } else if (Platform.isIOS) {
    // Request permission to access photos and files on iOS and macOS
    if (await Permission.photos.isGranted) {
      debugPrint('Photos permission already granted.');
      return;
    }

    if (await Permission.photos.isPermanentlyDenied) {
      openAppSettings();
      return;
    }

    await Permission.photos.request();
  } else if (Platform.isWindows) {
    // Permissions are not normally required on Windows, but should be checked
    debugPrint('No special permissions needed for Windows.');
  } else if (Platform.isMacOS) {
    // Request permission to access photos and files on iOS and macOS
    if (await Permission.photos.isGranted) {
      debugPrint('Photos permission already granted.');
      return;
    }

    if (await Permission.photos.isPermanentlyDenied) {
      openAppSettings();
      return;
    }

    await Permission.photos.request();
  } else {
    debugPrint('Unsupported platform.');
  }
}
*/

/*-bool _isRequestingPermissions = false;

Future<void> handlePermissions() async {
  if (_isRequestingPermissions) {
    debugPrint('A permission request is already in progress');
    return;
  }

  _isRequestingPermissions = true;

  try {
    if (Platform.isAndroid) {
      await _handleAndroidPermissions();
    } else if (Platform.isIOS) {
      await _handleIOSPermissions();
    } else if (Platform.isWindows) {
      debugPrint('No special permissions needed for Windows.');
    } else if (Platform.isMacOS) {
      await _handleMacOSPermissions();
    } else {
      debugPrint('Unsupported platform.');
    }
  } catch (e) {
    debugPrint('Error requesting permissions: $e');
  } finally {
    _isRequestingPermissions = false;
  }
}

Future<void> _handleAndroidPermissions() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  final int sdkInt = androidInfo.version.sdkInt;

  if (sdkInt >= 33) {
    await _requestAndroidApi33Permissions();
  } else if (sdkInt >= 29) {
    await _requestAndroidApi29Permissions();
  } else {
    await _requestAndroidLegacyPermissions();
  }
}

Future<void> _requestAndroidApi33Permissions() async {
  final Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
    Permission.photos,
    Permission.videos,
    Permission.audio,
  ].request();

  if (statuses.values.every((status) => status.isGranted)) {
    debugPrint('All permissions granted');
  } else {
    _handleDeniedPermissions(statuses);
  }
}

Future<void> _requestAndroidApi29Permissions() async {
  final cameraStatus = await Permission.camera.request();
  final audioStatus = await Permission.audio.request();
  final storageStatus = await Permission.storage.request();
  final manageExternalStorageStatus = await Permission.manageExternalStorage.request();

  if ([cameraStatus, audioStatus, storageStatus, manageExternalStorageStatus].every((status) => status.isGranted)) {
    debugPrint('All permissions granted');
  } else {
    _handleDeniedPermissions({
      Permission.camera: cameraStatus,
      Permission.audio: audioStatus,
      Permission.storage: storageStatus,
      Permission.manageExternalStorage: manageExternalStorageStatus,
    });
  }
}

Future<void> _requestAndroidLegacyPermissions() async {
  final cameraStatus = await Permission.camera.request();
  final audioStatus = await Permission.audio.request();
  final storageStatus = await Permission.storage.request();

  if ([cameraStatus, audioStatus, storageStatus].every((status) => status.isGranted)) {
    debugPrint('All permissions granted');
  } else {
    _handleDeniedPermissions({
      Permission.camera: cameraStatus,
      Permission.audio: audioStatus,
      Permission.storage: storageStatus,
    });
  }
}

Future<void> _handleIOSPermissions() async {
  if (await Permission.photos.isGranted) {
    debugPrint('Photos permission already granted.');
    return;
  }

  if (await Permission.photos.isPermanentlyDenied) {
    openAppSettings();
    return;
  }

  final status = await Permission.photos.request();
  if (status.isGranted) {
    debugPrint('Photos permission granted');
  } else {
    debugPrint('Photos permission denied');
  }
}

Future<void> _handleMacOSPermissions() async {
  if (await Permission.photos.isGranted) {
    debugPrint('Photos permission already granted.');
    return;
  }

  if (await Permission.photos.isPermanentlyDenied) {
    openAppSettings();
    return;
  }

  final status = await Permission.photos.request();
  if (status.isGranted) {
    debugPrint('Photos permission granted');
  } else {
    debugPrint('Photos permission denied');
  }
}

void _handleDeniedPermissions(Map<Permission, PermissionStatus> statuses) {
  if (statuses.values.any((status) => status.isPermanentlyDenied)) {
    debugPrint('Some permissions are permanently denied. Please open app settings.');
    openAppSettings();
  } else {
    debugPrint('Some permissions were denied. Please request again.');
  }
}
*/
