import 'package:flutter/material.dart';
import 'package:mallang/Widget/ageBook.dart';
import 'package:mallang/Widget/mypage.dart';
import 'package:mallang/Widget/myLibrary.dart';
import 'package:mallang/Widget/notification.dart';
import 'package:mallang/Widget/brandNewBook.dart';
import 'package:mallang/Widget/popularBook.dart';
import 'package:mallang/Widget/category.dart';
import 'package:mallang/Widget/test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String email;
  const HomePage(this.email);

  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<HomePage> {
  int _selectedIndex = 1; // Track the selected index
  String? userName;

  // 사용자가 검색한 내용
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final response = await http.get(Uri.parse('http://20.249.17.142:8000/account/get/${widget.email}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        userName = data['name'];
      });
    } else {
      throw Exception('유저 정보를 가져올 수 없습니다');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false, // 제목을 가운데 정렬하지 않음
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        backgroundColor: const Color(0xffffd966),
        title: Row(
          children: [
            Image.asset(
              'assets/images/appbar.png', // 이미지 경로 지정
              width: 120, // 이미지 너비 조절
              height: 140, // 이미지 높이 조절
            ),
            const SizedBox(width: 10), // 이미지와 텍스트 사이의 간격 조절
          ],
        ),
        actions: [
          IconButton(
            // 업데이트 사항, 신규 동화책 등록 등 알림 볼 수 있게 하기
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xffffd966),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/배경.png'),
            fit: BoxFit.cover,
          ),
        ),
        //color: Color(0xffF4f1b1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              _searchBox(),
              const SizedBox(height: 20,),
              _recommendBook(),
              const SizedBox(height: 20,),
              _fourMenu(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 1) {
            } else if (_selectedIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyLibrary()),
              );
            } else if (_selectedIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPage(widget.email)),
              );
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "내 서재",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "관리",
          ),
        ],
      ),
    );
  }

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
            'assets/images/검색토끼.png',
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
                  _buildBook('assets/images/토끼와거북이.png', '토끼와 거북이', width: 150, height: 200),
                  _buildBook('assets/images/구름빵.png', '구름빵', width: 150, height: 200),
                  _buildBook('assets/images/인기도서5.png', '도도도 도착!', width: 150, height: 200),
                  _buildBook('assets/images/해님달님.png', '해님달님', width: 150, height: 200),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBook(String imagePath, String title, {double width = 150, double height = 180}) {
    return GestureDetector(
      onTap: () {
        if (title == '토끼와 거북이') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Test(widget.email, title)),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _fourMenu(){
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
            _buildCard('연령별 추천도서', 'assets/images/chickchick.png', Color(0xffb0c4de)),
            _buildCard('카테고리', 'assets/images/dinasour.png', Color(0xffffb6c1)),
          ],
        ),
      ],
    );
  }
}
