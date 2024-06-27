import 'package:flutter/material.dart';
import 'package:mallang/Widget/test.dart'; // Test 클래스가 정의된 파일의 경로에 따라 수정 필요

class BrandNewBookPage extends StatelessWidget {
  final String email;

  const BrandNewBookPage({Key? key, required this.email}) : super(key: key);

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
              const SizedBox(height: 20),
              _BookRow(context, [
                BookInfo(
                    imagePath: 'assets/images/rabbit_and_turtle.png',
                    title: '토끼와 거북이'),
                BookInfo(
                    imagePath: 'assets/images/sun_and_moon.png',
                    title: '해와달이된오누이'),
                BookInfo(
                    imagePath: 'assets/images/여우와두루미.png', title: '여우와두루미'),
              ]),
              const SizedBox(height: 20),
              _BookRow(context, [
                BookInfo(
                    imagePath: 'assets/images/parrot_book.png',
                    title: '앵무새와숲의친구들'),
                BookInfo(
                    imagePath: 'assets/images/여기는 토끼아파트입니다.png',
                    title: '여기는 토끼 아파트입니다'),
                BookInfo(imagePath: 'assets/images/구름빵.png', title: '구름빵'),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _BookRow(BuildContext context, List<BookInfo> books) {
    final navigableTitles = ['토끼와 거북이', '해와달이된오누이', '여우와두루미', '앵무새와숲의친구들'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: books.map((book) {
        return GestureDetector(
          onTap: () {
            if (navigableTitles.contains(book.title)) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Test(email, book.title),
                ),
              );
            }
          },
          child: Column(
            children: [
              _buildBookImage(book.imagePath),
              const SizedBox(height: 8),
              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
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

class BookInfo {
  final String imagePath;
  final String title;

  BookInfo({required this.imagePath, required this.title});
}
