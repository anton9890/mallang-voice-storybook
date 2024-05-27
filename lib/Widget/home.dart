import 'package:flutter/material.dart';
import 'package:mallang/Widget/popularBook.dart';
import 'package:mallang/Widget/test.dart';
import 'ageBook.dart';
import 'brandNewBook.dart';
import 'category.dart';

class HomePage extends StatelessWidget {
  final String email;
  final String userName;

  const HomePage({super.key, required this.email, required this.userName});

  @override
  Widget build(BuildContext context) {
    // 사용자가 검색한 내용
    final TextEditingController _searchController = TextEditingController();

    Widget _searchBox() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: TextField(
          controller: _searchController,
          onSubmitted: (value) {
            // 'value'는 사용자가 입력한 텍스트
            print('검색어: $value');
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: '동화책을 검색해주세요',
            hintStyle: const TextStyle(fontFamily: 'Pretendard'),
            prefixIcon: Image.asset(
              'assets/images/search.gif',
              width: 20, // 이미지의 너비 설정
              height: 24, // 이미지의 높이 설정
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none, // 테두리 색상 없애기
            ),
          ),
        ),
      );
    }

    Widget _buildBook(String imagePath, String title,
        {double width = 150, double height = 180}) {
      return GestureDetector(
        onTap: () {
          if (title == '토끼와 거북이') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Test(email, title)),
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                width: width,
                height: height,
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontFamily: 'Pretendard'),
              ),
            ],
          ),
        ),
      );
    }

    Widget _recommendBook() {
      return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.only(left: 0, top: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '$userName님을 위한 취향저격 도서 📚',
                      style: const TextStyle(
                        fontSize: 22, // 폰트 크기 조정
                        fontFamily: 'Pretendard',
                        color: Color(0xff929292),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildBook('assets/images/토끼와거북이.png', '토끼와 거북이',
                        width: 150, height: 200),
                    _buildBook('assets/images/구름빵.png', '구름빵',
                        width: 150, height: 200),
                    _buildBook('assets/images/인기도서5.png', '도도도 도착!',
                        width: 150, height: 200),
                    _buildBook('assets/images/해님달님.png', '해님달님',
                        width: 150, height: 200),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildCard(String text, String imagePath, Color color) {
      Widget? targetScreen;

      switch (text) {
        case '신간도서':
          targetScreen = BrandNewBookPage();
          break;
        case '인기도서':
          targetScreen = PopularBook();
          break;
        case '연령별 추천도서':
          targetScreen = AgeBookPage();
          break;
        case '카테고리':
          targetScreen = CategoryPage();
          break;
        default:
          break;
      }

      return InkWell(
        onTap: () {
          if (targetScreen != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetScreen!),
            );
          }
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 18.0, // 모든 텍스트의 크기를 동일하게 설정합니다.
                    color: color, // 텍스트의 색깔을 설정합니다.
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget _fourMenu() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCard('신간도서', 'assets/images/carrot.png', Color(0xffffa07a)),
              _buildCard('인기도서', 'assets/images/turtle.png', Color(0xffADD797)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCard('연령별 추천도서', 'assets/images/chickchick.png',
                  Color(0xffb0c4de)),
              _buildCard(
                  '카테고리', 'assets/images/dinasour.png', Color(0xffffb6c1)),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      // child: Container(
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('assets/images/배경.png'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
// color: Color(0xffF4f1b1),
      backgroundColor: Color(0xffF4f1b1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _searchBox(),
            const SizedBox(
              height: 20,
            ),
            _recommendBook(),
            const SizedBox(
              height: 20,
            ),
            _fourMenu(),
          ],
        ),
      ),
    );
  }
}
