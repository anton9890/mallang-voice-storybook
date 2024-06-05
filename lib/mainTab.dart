import 'package:flutter/material.dart';
import 'package:mallang/Widget/home.dart';
import 'package:mallang/Widget/myLibrary.dart';
import 'package:mallang/Widget/mypage.dart';
import 'package:mallang/Widget/notification.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainTabPage extends StatefulWidget {
  final String email;

  const MainTabPage(this.email, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainTabState();
  }
}

class _MainTabState extends State<MainTabPage> {
  int _selectedIndex = 0; // Track the selected index
  String userName = "";

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final response = await http.get(
        Uri.parse('http://4.217.252.206:8000/account/get/${widget.email}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        userName = data['name'];
      });
    } else {
      throw Exception('유저 정보를 가져올 수 없습니다');
    }
  }

  List<Widget> tabItems() {
    return <Widget>[
      HomePage(email: widget.email, userName: userName),
      MyLibraryPage(),
      MyPage(widget.email),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffd966),
        title: Row(
          children: [
            SizedBox(
              width: 120,
              child: Image.asset(
                'assets/images/main.gif',
              ),
            ),
            const SizedBox(width: 10), // 이미지와 텍스트 사이의 간격 조절
          ],
        ),
        actions: [
          IconButton(
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
      body: SafeArea(
        child: tabItems().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "내 서재",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "관리",
          ),
        ],
      ),
    );
  }
}
