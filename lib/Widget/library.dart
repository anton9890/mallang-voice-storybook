import 'package:flutter/material.dart';
import 'package:mallang/MainPage.dart';

void main() {
   runApp(MyLibrary());
}
class MyLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Library',
      home: MyLibraryPage(),
    );
  }
}
class MyLibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 서재'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
              ),
              child: Text(
                '전체 도서',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'assets/images/토끼와거북이.png',
              ),
              title: Text('토끼와 거북이'),
              subtitle: Text('73% 읽는 중'),
            ),
            ListTile(
              leading: Image.asset(
                  'assets/images/호박목욕탕.png'),
              title: Text('호박 목욕탕'),
              subtitle: Text('68% 읽는 중'),
            ),
            ListTile(
              leading: Image.asset(
                  'assets/images/인기도서1.png'),
              title: Text('내 사랑 티라노'),
              subtitle: Text('14% 읽는 중'),
            ),
            ListTile(
              leading: Image.asset(
                  'assets/images/구름빵.png'),
              title: Text('구름빵'),
              subtitle: Text('59% 읽는 중'),
            ),
            ListTile(
              leading: Image.asset(
                  'assets/images/여우와두루미.png'),
              title: Text('여우와 두루미'),
              subtitle: Text('23% 읽는 중'),
            ),
            ListTile(
              leading: Image.asset(
                  'assets/images/인기도서3.png'),
              title: Text('미로야 놀자'),
              subtitle: Text('54% 읽는 중'),
            ),
          ],
        ),
      ),
    );
  }
}
//
// class MyLibrary extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: Text('Photo Grid')),
//         body: PhotoGrid(),
//       ),
//     );
//   }
// }
//
// class PhotoGrid extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisCount: 1,
//       children: <Widget>[
//         _buildPhotoWithDescription('assets/images/image1.jpg', '설명 1'),
//         _buildPhotoWithDescription('assets/images/image2.jpg', '설명 2'),
//         _buildPhotoWithDescription('assets/images/image3.jpg', '설명 3'),
//         _buildPhotoWithDescription('assets/images/image4.jpg', '설명 4'),
//         _buildPhotoWithDescription('assets/images/image5.jpg', '설명 5'),
//       ],
//     );
//   }
//
//   Widget _buildPhotoWithDescription(String imagePath, String description) {
//     return Column(
//       children: <Widget>[
//         Image.asset(imagePath),
//         SizedBox(height: 8), // 사진과 설명 사이의 간격 조정
//         Text(description),
//       ],
//     );
//   }
// }
