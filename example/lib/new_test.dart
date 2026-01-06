import 'package:avatar_better/avatar_better.dart';
import 'package:flutter/material.dart';

class NewTest extends StatelessWidget {
  const NewTest({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NewTest')),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Avatar(
              text: 'NewTest',
              radius: 45,
              randomColor: true,
              randomGradient: false,
            ),
            SizedBox(height: 20),
            Avatar.profile(
              text: 'NewTest',
              radius: 45,
              randomColor: true,
              randomGradient: false,
            ),
          ],
        ),
      ),
    );
  }
}
