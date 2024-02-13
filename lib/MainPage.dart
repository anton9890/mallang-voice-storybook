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

  // 사용자가 검색한 내용
  final TextEditingController _searchController = TextEditingController();

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
        ],
      ),
      body: Column(
        children: [
          _serchBox(),
          SizedBox(height: 20,),
          _thirdMenu(),
          Divider( // 추가한 선
            color: Colors.grey,
            height: 20,
            thickness: 1,
          ),
          _recommendMenu(),
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

  Widget _serchBox(){
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: '동화책을 검색해주세요',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => _searchController.clear(),
            ),
            prefixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                // 검색창 누르면 보일 화면
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )
          ),
        ),
      ),
    );
  }

  Widget _thirdMenu(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            InkWell(
              child: Image.asset('assets/images/star.png', width: 40, height: 40,),
              onTap:(){},
            ),
            Text('추천', style: TextStyle(color: Colors.black.withOpacity(0.5))) // 텍스트 추가
          ],
        ),
        Column(
          children: [
            InkWell(
              child: Image.asset('assets/images/rainbow.png', width: 40, height: 40,),
              onTap:(){},
            ),
            Text('인기', style: TextStyle(color: Colors.black.withOpacity(0.5))) // 텍스트 추가
          ],
        ),
        Column(
          children: [
            InkWell(
              child: Image.asset('assets/images/flower.png', width: 40, height: 40,),
              onTap: (){},
            ),
            Text('카테고리', style: TextStyle(color: Colors.black.withOpacity(0.5))) // 텍스트 추가
          ],
        ),
      ],
    );
  }

  Widget _recommendMenu(){
    return Container(
      child: Text('김찬돌님 이 동화책은 어떠세요?'),
    );
  }

}
