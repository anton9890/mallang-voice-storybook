import 'package:flutter/material.dart';
import 'CombinedPage.dart';
import 'main.dart';
import 'home.dart';
import 'package:mallang/Widget/Mypage.dart';
// import 'package:mallang/Widget/call.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<MainPage> {
  int _selectedIndex = 0; // Track the selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            icon: Icon(Icons.add_alert),
            onPressed: () {},
          ),
          IconButton(
            // 동화책 카테고리? 관심사 별로 볼 수 있게 하기
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
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
              // 서재 페이지로 이동
              // 예시: Navigator.push(context, MaterialPageRoute(builder: (context) => LibraryPage()),);
            } else if (_selectedIndex == 2) {
              // 마이 페이지로 이동
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
            label: "서재",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "마이 페이지",
          ),
        ],
      ),
    );
  }
}
