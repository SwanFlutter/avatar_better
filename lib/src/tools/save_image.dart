import 'dart:io';
import 'dart:math';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class ImageSaver {
  static Future<File> saveImageFile(File fileImage) async {
    final PathProviderPlatform provider = PathProviderPlatform.instance;
    String filePath = '';
    Directory? downloadDirectoryWindows = await getDownloadsDirectory();
    String? downloadDirectoryAndroid = await AndroidPathProvider.downloadsPath;
    String? downloadDirectoryIos = await provider.getDownloadsPath();
    String? downloadDirectoryMac = await provider.getDownloadsPath();

    // بدست آوردن مسیر دانلود پیش‌فرض اندروید
    final Directory defaultDownloadDirectory =
        Directory('/storage/emulated/0/Download');

    String fileName = randomFileName(4);

    if (kIsWeb &&
        downloadDirectoryWindows != null &&
        await downloadDirectoryWindows.exists()) {
      filePath = '${downloadDirectoryWindows.path}/$fileName.jpg';
    } else if (Platform.isAndroid) {
      filePath = '$downloadDirectoryAndroid/$fileName.jpg';
    } else if (Platform.isIOS && downloadDirectoryIos != null) {
      filePath = '$downloadDirectoryIos/$fileName.jpg';
    } else if (Platform.isMacOS && downloadDirectoryMac != null) {
      filePath = '$downloadDirectoryMac/$fileName.jpg';
    } else if (await defaultDownloadDirectory.exists() && Platform.isAndroid) {
      filePath = '${defaultDownloadDirectory.path}/$fileName.jpg';
    } else {
      throw Exception('Download directory not found');
    }

    final File newImage = await fileImage.copy(filePath);
    return newImage;
  }

////////////////////

  static Future<File> saveImage(String imageLink) async {
    try {
      var response = await http.get(Uri.parse(imageLink));

      final Directory downloadDirectory =
          Directory('/storage/emulated/0/Download');

      String fileName = path.basename(imageLink);
      // ignore: unused_local_variable
      String extension = path.extension(fileName);
      String baseName = path.basenameWithoutExtension(fileName);

      Map<String, String> fileExtensions = {
        'image/jpeg': '.jpg',
        'image/png': '.png',
        'video/mp4': '.mp4',
        'application/pdf': '.pdf',
      };

      String fileExtension =
          fileExtensions[response.headers['content-type']] ?? '.png';

      File filePath =
          File(path.join(downloadDirectory.path, '$baseName$fileExtension'));

      await filePath.writeAsBytes(response.bodyBytes);
      return filePath;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error during image download: $e');
        print('Stack Trace: $stackTrace');
      }
      throw Exception('Error during image download: $e');
    }
  }
}

String randomFileName(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  try {
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  } catch (e, stackTrace) {
    if (kDebugMode) {
      print('Error generating random filename: $e');
      print('Stack Trace: $stackTrace');
    }
    throw Exception('Error generating random filename: $e');
  }
}
