// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Handles permissions based on the Android version.
///
/// Requests different permissions depending on the Android version.
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
