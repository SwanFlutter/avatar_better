import 'dart:io';

import 'package:avatar_better/avatar_better.dart';
import 'package:example/new.dart';
import 'package:flutter/material.dart';

import 'avatar_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AvatarExample(),
    );
  }
}

class AvatarExample extends StatefulWidget {
  const AvatarExample({super.key});

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
    'Z',
  ];

  List<String> avatar = List.generate(
    52,
    (index) => "${alphabet[index]} avatar ${index + 1} ",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => New()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AvatarExampleProfile(),
              ),
            );
          },
          icon: const Icon(Icons.nat),
        ),
      ),
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
                        Avatar(
                          // onTapAvatar: () {},
                          radius: 35,
                          // showPageViewOnTap: true,
                          text: avatar[index],
                          randomGradient: true,
                          randomColor: false,
                          useMaterialColorForGradient: true,
                          mixColorForGradient: false,
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
