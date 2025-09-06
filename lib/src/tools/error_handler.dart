import 'package:flutter/foundation.dart';

class ErrorHandler {
  static void initialize() {
    if (kDebugMode) {
      // Filter out known Flutter framework errors
      FlutterError.onError = (FlutterErrorDetails details) {
        final String error = details.toString();
        
        // Filter out keyboard event errors
        if (error.contains('KeyDownEvent is dispatched') ||
            error.contains('_pressedKeys.containsKey') ||
            error.contains('Unable to parse JSON message')) {
          // Ignore these known framework issues
          return;
        }
        
        // Log other errors normally
        FlutterError.presentError(details);
      };
    }
  }
}