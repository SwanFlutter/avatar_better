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

  List<String> avatar =
      List.generate(52, (index) => "${alphabet[index]} avatar ${index + 1} ");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < avatar.length) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Avatar.profile(
                          imageNetwork: "https://i.pravatar.cc/300",
                          // onTapAvatar: () {},
                          radius: 35,
                          // showPageViewOnTap: true,
                          text: avatar[index],
                          randomGradient: true,
                          randomColor: false,
                        ),
                        Text(avatar[index]),
                      ],
                    ),
                  );
                } else {
                  // Return the additional Avatar widget
                  return const SizedBox(height: 25);
                }
              },
              childCount:
                  avatar.length + 1, // +1 for the additional Avatar widget
            ),
          ),
        ],
      ),
    );
  }
}
