import 'package:flutter/material.dart';

class BrandNewBookPage extends StatelessWidget {
  const BrandNewBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '신간도서',
          style: TextStyle(
            fontFamily: 'Moebius',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBookImage('assets/images/rabbit_and_turtle.png'),
                  _buildBookImage('assets/images/여우와두루미.png'),
                  _buildBookImage('assets/images/parrot_book.png'),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBookImage('assets/images/sun_and_moon.png'),
                  _buildBookImage('assets/images/여기는 토끼아파트입니다.png'),
                  _buildBookImage('assets/images/구름빵.png'),
                ],
              ),
              const SizedBox(height: 40), // 스크롤의 마지막 간격
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
