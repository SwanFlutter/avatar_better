import 'dart:io';

import 'package:avatar_better/avatar_better.dart';
import 'package:flutter/material.dart';

class AvatarExample extends StatefulWidget {
  const AvatarExample({Key? key}) : super(key: key);

  @override
  State<AvatarExample> createState() => _AvatarExampleState();
}

class _AvatarExampleState extends State<AvatarExample> {
  File? image;

  static List<String> alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  List<String> avatar = List.generate(52, (index) => "${alphabet[index]} avatar ${index + 1} ");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              /*  ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: avatar.length,
                itemBuilder: (context, index) {
                  // Check if the index is within the bounds of the list
                  if (index < avatar.length) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Avatar(
                            onTapAvatar: () {},
                            radius: 35,
                            text: avatar[index],
                            randomGradient: true,
                            randomColor: false,
                          ),
                          Text(avatar[index]),
                        ],
                      ),
                    );
                  } else {
                    // Return a placeholder widget if the index is out of bounds
                    return Container();
                  }
                },
              ),*/
              const SizedBox(height: 25),
              Avatar(
                showPageViewOnTap: true,
                text: "S",
                imageNetwork: "https://i.pravatar.cc/300",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
