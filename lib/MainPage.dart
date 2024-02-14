// import 'package:flutter/material.dart';
// import 'main.dart';
// import 'home.dart';
// import 'package:mallang/Widget/Mypage.dart';
// import 'package:mallang/Widget/library.dart';
// import 'package:mallang/Widget/Alert.dart';
//
// class MainPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _MainState();
//   }
// }
//
// class _MainState extends State<MainPage> {
//   int _selectedIndex = 0; // Track the selected index
//
//   // 사용자가 검색한 내용
//   final TextEditingController _searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
//         title: Text(
//           "말랑",
//           style: TextStyle(
//             fontSize: 20,
//           ),
//         ),
//         actions: [
//           IconButton(
//             // 업데이트 사항, 신규 동화책 등록 등 알림 볼 수 있게 하기
//             icon: Icon(Icons.add_alert),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           _searchBox(),
//           SizedBox(height: 20,),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.green,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//             if (_selectedIndex == 1) {
//               // 홈 페이지로 이동
//               // 예시: Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
//             } else if (_selectedIndex == 0) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Mylibrary()),
//               );
//             } else if (_selectedIndex == 2) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => MyPage()),
//               );
//             }
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book),
//             label: "내 서재",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "홈",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: "관리",
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _searchBox() {
//     return Padding(
//       padding: EdgeInsets.all(8),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: '동화책을 검색해주세요',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.clear),
//                   onPressed: () => _searchController.clear(),
//                 ),
//                 prefixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () {
//                     // 검색창 누르면 보일 화면
//                   },
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 30),
//           Container(
//             width: double.infinity,
//             height: 180,
//             decoration: BoxDecoration(
//               color: Colors.yellow[100],
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 3,
//                   blurRadius: 7,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: EdgeInsets.only(left: 10, top: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '김찬돌님 취향저격 도서',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         Image.asset(
//                           'assets/images/구름빵.png',
//                           width: 100,
//                           height: 100,
//                         ),
//                         // SizedBox(width: ), // 이미지 사이의 간격
//                         Image.asset(
//                           'assets/images/토끼와거북이.png',
//                           width: 100,
//                           height: 100,
//                         ),
//                         SizedBox(width: 8), // 이미지 사이의 간격
//                         Image.asset(
//                           'assets/images/흥부놀부.png',
//                           width: 100,
//                           height: 100,
//                         ),
//                         SizedBox(width: 8), // 이미지 사이의 간격
//                         Image.asset(
//                           'assets/images/해와달이된오누이.png',
//                           width: 100,
//                           height: 100,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'main.dart';
import 'home.dart';
import 'package:mallang/Widget/Mypage.dart';
import 'package:mallang/Widget/library.dart';
import 'package:mallang/Widget/Alert.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _searchBox(),
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

  Widget _searchBox() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
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
                  onPressed: () {
                    // 검색창 누르면 보일 화면
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
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
          ),
        ],
      ),
    );
  }

  Widget _buildBook(String imagePath, String title) {
    return Column(
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
    );
  }
  Widget _buildCard(String text, String imagePath, Color color){
    return InkWell(
      onTap: (){},
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
                  fontSize: 15.0,  // 모든 텍스트의 크기를 동일하게 설정합니다.
                  color: color,  // 텍스트의 색깔을 설정합니다.
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

  // 메뉴 만들기
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

