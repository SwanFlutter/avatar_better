import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class ImageSaver {
  static Future<File> saveImageFile(File fileImage) async {
    final Directory downloadDirectory =
        Directory('/storage/emulated/0/Download');

    String fileName = randomFileName(5);

    if (!await downloadDirectory.exists()) {
      await downloadDirectory.create(recursive: true);
    }

    final String filePath = '${downloadDirectory.path}/$fileName.jpeg';
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
