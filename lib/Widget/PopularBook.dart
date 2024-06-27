import 'package:flutter/material.dart';
import 'package:mallang/Widget/test.dart';

class PopularBook extends StatelessWidget {
  final String email;

  const PopularBook({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '인기도서',
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
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 30, // Container의 높이 설정
                color: Colors.yellow[100], // 배경색 설정
                child: const Center(
                  child: Text(
                    '인기도서 베스트 12',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Moebius',
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildBookRow(context, [
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
              _buildBookRow(context, [
                BookInfo(
                    imagePath: 'assets/images/parrot_book.png',
                    title: '앵무새와숲의친구들'),
                BookInfo(
                    imagePath: 'assets/images/인기도서5.png', title: '도도도 도착!'),
                BookInfo(
                    imagePath: 'assets/images/인기도서6.png', title: '아빠랑 간질간질'),
              ]),
              const SizedBox(height: 20),
              _buildBookRow(context, [
                BookInfo(
                    imagePath: 'assets/images/도와줘,브루너.png', title: '도와줘, 브루너'),
                BookInfo(
                    imagePath: 'assets/images/봄날의즐거운모자대회.png',
                    title: '봄날의 즐거운 모자 대회'),
                BookInfo(imagePath: 'assets/images/변신요가.png', title: '변신 요가'),
              ]),
              SizedBox(height: 20),
              _buildBookRow(context, [
                BookInfo(
                    imagePath: 'assets/images/인기도서1.png', title: '내 사랑 티라노'),
                BookInfo(
                    imagePath: 'assets/images/인기도서2.png', title: '밥의 오싹오싹 맛집'),
                BookInfo(imagePath: 'assets/images/친구의전설.png', title: '친구의 전설'),
              ]),
              const SizedBox(height: 20), // 스크롤의 마지막 간격
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookRow(BuildContext context, List<BookInfo> books) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: books.map((book) {
        return _buildBookImage(context, book.imagePath, book.title);
      }).toList(),
    );
  }

  Widget _buildBookImage(BuildContext context, String imagePath, String title) {
    final navigableTitles = ['토끼와 거북이', '해와달이된오누이', '여우와두루미', '앵무새와숲의친구들'];

    return GestureDetector(
      onTap: () {
        if (navigableTitles.contains(title)) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Test(email, title)),
          );
        }
      },
      child: Column(
        children: [
          Container(
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
          ),
          const SizedBox(height: 5), // 텍스트와 이미지 사이의 간격 조절
          Text(
            title,
            style: const TextStyle(
                fontSize: 12, fontFamily: 'Moebius'), // 텍스트의 크기 조절
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
