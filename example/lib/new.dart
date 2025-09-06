import 'dart:io';
import 'dart:typed_data';

import 'package:avatar_better/avatar_better.dart';
import 'package:flutter/material.dart';

class New extends StatefulWidget {
  const New({super.key});

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  File? image;
  Uint8List? imageBytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 50,
            children: [
              Avatar.profile(
                optionsCrop: OptionsCrop(cropperTheme: CropperTheme()),
                text: "S",
                onPickerChange: (file) {
                  setState(() {
                    image = file;
                  });
                },
                onPickerChangeWeb: (bytes) {
                  setState(() {
                    imageBytes = bytes;
                  });
                },
              ),
              if (image != null)
                Image.file(image!, width: 300, height: 300)
              else if (imageBytes != null)
                Image.memory(imageBytes!)
              else
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
                ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                  image: imageBytes != null
                      ? DecorationImage(
                          image: MemoryImage(imageBytes!),
                          fit: BoxFit.cover,
                        )
                      : image != null
                      ? DecorationImage(
                          image: FileImage(image!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: imageBytes == null && image == null
                    ? Icon(Icons.person, size: 30, color: Colors.grey[600])
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
