import 'package:flutter/material.dart';
import 'CombinedPage.dart';
import 'main.dart';
import 'home.dart';
import 'package:mallang/Widget/Mypage.dart';
import 'package:mallang/Widget/call.dart';

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
        centerTitle: true,
        automaticallyImplyLeading: true, // 뒤로가기 버튼 제거
        title: Text("말랑"),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search)
        //   )
        // ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Handle item selection here
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPage()),
              );
            }
          });
          // Handle item selection here
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PhonePage()),
              );
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.speaker_notes),
            label: "말랑 토크",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_forwarded),
            label: "전화",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: "분석",
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
