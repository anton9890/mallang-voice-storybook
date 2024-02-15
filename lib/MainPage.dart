import 'package:flutter/material.dart';
import 'main.dart';
import 'home.dart';
import 'package:mallang/Widget/Mypage.dart';
import 'package:mallang/Widget/library.dart';
import 'package:mallang/Widget/Alert.dart';
import 'package:mallang/Widget/BrandNew.dart';
import 'package:mallang/Widget/PopularBook.dart';
import 'package:mallang/pagetest.dart'; // 페이지 테스트 추가
import 'package:mallang/Widget/cartagory.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<MainPage> {
  int _selectedIndex = 1; // Track the selected index

  // 사용자가 검색한 내용
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        title: Text(
          "말랑",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            // 업데이트 사항, 신규 동화책 등록 등 알림 볼 수 있게 하기
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlertPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _searchBox(),
            SizedBox(height: 20,),
            _recommendBook(),
            SizedBox(height: 20,),
            _fourMenu(),
          ],
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
              // 홈 페이지로 이동
              // 예시: Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
            } else if (_selectedIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Mylibrary()),
              );
            } else if (_selectedIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPage()),
              );
            }
          });
        },
        items: [
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

  Widget _searchBox(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: TextField(
        controller: _searchController,
        onSubmitted: (value) {
          // 'value'는 사용자가 입력한 텍스트
          print('검색어: $value');
        },
        decoration: InputDecoration(
          hintText: '동화책을 검색해주세요',
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => _searchController.clear(),
          ),
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 검색창 누르면 보일 화면
              print('검색어: ${_searchController.text}');
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _recommendBook(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, // 90%의 가로 공간을 차지하도록 설정
      height: 200,
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 13, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '김찬돌님 취향저격 도서',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildBook('assets/images/구름빵.png', '구름빵'),
                  _buildBook('assets/images/토끼와거북이.png', '토끼와거북이'),
                  _buildBook('assets/images/흥부놀부.png', '흥부와 놀부'),
                  _buildBook('assets/images/해님달님.png', '해님달님'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBook(String imagePath, String title) {
    return GestureDetector(
      onTap: () {
        if (title == '토끼와거북이') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => test()), // pagetest 페이지로 이동
          );
        }
      },
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
          ),
          SizedBox(height: 7), // 이미지와 텍스트 사이 간격
          Text(
            title,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String text, String imagePath, Color color) {
    Widget? targetScreen;

    switch (text) {
      case '신간도서':
        targetScreen = brandnewbook();
        break;
      case '인기도서':
        targetScreen = PopularBook();
        break;
    //case '연령별 추천 도서':
      case '카테고리':
        targetScreen = cartagory();
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
          width: 130,
          height: 130,
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
                  fontSize: 15.0, // 모든 텍스트의 크기를 동일하게 설정합니다.
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
            _buildCard('신간도서', 'assets/images/star.png', Color(0xffffa07a)),
            _buildCard('인기도서', 'assets/images/heart.png', Color(0xffADD797)),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCard('연령별 추천도서', 'assets/images/recommand.png', Color(0xffb0c4de)),
            _buildCard('카테고리', 'assets/images/category.png', Color(0xffffb6c1)),
          ],
        ),
      ],
    );
  }
}
