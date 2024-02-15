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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBookImage('assets/images/토끼와거북이.png'),
                  _buildBookImage('assets/images/해님달님.png'),
                  _buildBookImage('assets/images/인기도서3.png'),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBookImage('assets/images/인기도서4.png'),
                  _buildBookImage('assets/images/인기도서5.png'),
                  _buildBookImage('assets/images/인기도서6.png'),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBookImage('assets/images/도와줘,브루너.png'),
                  _buildBookImage('assets/images/봄날의즐거운모자대회.png'),
                  _buildBookImage('assets/images/변신요가.png'),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBookImage('assets/images/인기도서1.png'),
                  _buildBookImage('assets/images/인기도서2.png'),
                  _buildBookImage('assets/images/친구의전설.png'),
                ],
              ),
              SizedBox(height: 20), // 스크롤의 마지막 간격
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookImage(String imagePath) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
