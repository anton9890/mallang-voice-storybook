import 'package:flutter/material.dart';
import 'package:mallang/CombinedPage.dart';
import '../main.dart';
import '../home.dart';
import 'package:mallang/Widget/brandnew.dart';
import 'package:mallang/MainPage.dart';

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => brandnewbook()),
                    );
                  },
                  child: Text('Back'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
