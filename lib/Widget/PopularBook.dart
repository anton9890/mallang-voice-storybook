import 'package:flutter/material.dart';
import 'package:mallang/CombinedPage.dart';
import '../main.dart';
import '../home.dart';
import 'package:mallang/pagetest.dart';

class PopularBook extends StatelessWidget {
  const PopularBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('인기도서'),
      ),
    );
  }
}
