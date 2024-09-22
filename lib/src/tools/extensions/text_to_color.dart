import 'package:flutter/material.dart';
import 'dart:math';

class TextToColor {
  static Random rand = Random();

  TextToColor._();

  static int _getInt(String? str) {
    if (str == null) {
      return 123456;
    }

    var hash = 919; // org:5381
    var shift = str.length > 5 ? 2 : 4;
    //int shift = rand.nextInt(4);

    for (var i = 0; i < str.length; i++) {
      //hash = (hash + str.codeUnitAt(i)) << shift;
      hash = hash + (str.codeUnitAt(i) << shift);
    }

    return hash;
  }

  static int toIntColor(str) {
    try {
      var hash = _getInt(str);
      var r = (hash & 0xFF0000) >> 8;
      var g = (hash & 0x00FF00) >> 4;
      var b = hash & 0x0000FF;

      var rr = r.toString();
      var gg = g.toString();
      var bb = b.toString();

      rr = rr.padLeft(2, '9');
      gg = gg.padLeft(2, '8');
      bb = bb.padLeft(2, '9');

      //var x = '0xFF' + rr.substring(rr.length - 2) + gg.substring(gg.length - 2) + bb.substring(bb.length - 2);
      var x =
          '0xFF${rr.substring(rr.length - 2)}${gg.substring(gg.length - 2)}${bb.substring(bb.length - 2)}';
      return int.parse(x);
    } catch (err) {
      return int.parse('0xFF999999');
    }
  }

  static Color toColor(str) {
    return Color(toIntColor(str));
  }
}
