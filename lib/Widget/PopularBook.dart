import 'package:flutter/material.dart';
import 'package:mallang/CombinedPage.dart';
import '../main.dart';
import '../home.dart';
import 'package:mallang/pagetest.dart';
//
// // 사진에 제목 표시하는 방법
// // class PopularBook extends StatelessWidget {
// //   const PopularBook({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         title: Text('인기도서'),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               SizedBox(height: 20),
// //               _buildBookRow([
// //                 BookInfo(imagePath: 'assets/images/토끼와거북이.png', text: '토끼와 거북이'),
// //                 BookInfo(imagePath: 'assets/images/해님달님.png', text: '해님달님'),
// //                 BookInfo(imagePath: 'assets/images/인기도서3.png', text: '인기도서3'),
// //               ]),
// //               SizedBox(height: 20),
// //               _buildBookRow([
// //                 BookInfo(imagePath: 'assets/images/인기도서4.png', text: '인기도서4'),
// //                 BookInfo(imagePath: 'assets/images/인기도서5.png', text: '인기도서5'),
// //                 BookInfo(imagePath: 'assets/images/인기도서6.png', text: '인기도서6'),
// //               ]),
// //               SizedBox(height: 20),
// //               _buildBookRow([
// //                 BookInfo(imagePath: 'assets/images/도와줘,브루너.png', text: '도와줘, 브루너'),
// //                 BookInfo(imagePath: 'assets/images/봄날의즐거운모자대회.png', text: '봄날의 즐거운 모자 대회'),
// //                 BookInfo(imagePath: 'assets/images/변신요가.png', text: '변신 요가'),
// //               ]),
// //               SizedBox(height: 20),
// //               _buildBookRow([
// //                 BookInfo(imagePath: 'assets/images/인기도서1.png', text: '인기도서1'),
// //                 BookInfo(imagePath: 'assets/images/인기도서2.png', text: '인기도서2'),
// //                 BookInfo(imagePath: 'assets/images/친구의전설.png', text: '친구의 전설'),
// //               ]),
// //               SizedBox(height: 20), // 스크롤의 마지막 간격
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildBookRow(List<BookInfo> books) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //       children: books.map((book) {
// //         return _buildBookImage(book.imagePath, book.text);
// //       }).toList(),
// //     );
// //   }
// //
// //   Widget _buildBookImage(String imagePath, String text) {
// //     return Container(
// //       width: 100,
// //       height: 200, // Adjusted height to accommodate the text
// //       child: Stack(
// //         children: [
// //           Container(
// //             width: 100,
// //             height: 150,
// //             decoration: BoxDecoration(
// //               image: DecorationImage(
// //                 image: AssetImage(imagePath),
// //                 fit: BoxFit.cover,
// //               ),
// //               borderRadius: BorderRadius.circular(10),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.grey.withOpacity(0.5),
// //                   spreadRadius: 3,
// //                   blurRadius: 7,
// //                   offset: Offset(0, 3),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Positioned(
// //             top: 0,
// //             left: 0,
// //             right: 0,
// //             child: Container(
// //               padding: EdgeInsets.all(8),
// //               decoration: BoxDecoration(
// //                 color: Colors.black.withOpacity(0.5),
// //                 borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
// //               ),
// //               child: Text(
// //                 text,
// //                 style: TextStyle(color: Colors.white),
// //                 textAlign: TextAlign.center,
// //                 overflow: TextOverflow.ellipsis,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class BookInfo {
// //   final String imagePath;
// //   final String text;
// //
// //   BookInfo({required this.imagePath, required this.text});
// // }
//
//
// class PopularBook extends StatelessWidget {
//   const PopularBook({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('인기도서'),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildBookImage('assets/images/토끼와거북이.png'),
//                   _buildBookImage('assets/images/해님달님.png'),
//                   _buildBookImage('assets/images/인기도서3.png'),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildBookImage('assets/images/인기도서4.png'),
//                   _buildBookImage('assets/images/인기도서5.png'),
//                   _buildBookImage('assets/images/인기도서6.png'),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildBookImage('assets/images/도와줘,브루너.png'),
//                   _buildBookImage('assets/images/봄날의즐거운모자대회.png'),
//                   _buildBookImage('assets/images/변신요가.png'),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildBookImage('assets/images/인기도서1.png'),
//                   _buildBookImage('assets/images/인기도서2.png'),
//                   _buildBookImage('assets/images/친구의전설.png'),
//                 ],
//               ),
//               SizedBox(height: 20), // 스크롤의 마지막 간격
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBookImage(String imagePath) {
//     return Container(
//       width: 100,
//       height: 150,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(imagePath),
//           fit: BoxFit.cover,
//         ),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 3,
//             blurRadius: 7,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class PopularBook extends StatelessWidget {
  const PopularBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('인기도서'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              _buildBookRow([
                BookInfo(imagePath: 'assets/images/토끼와거북이.png', text: '토끼와 거북이'),
                BookInfo(imagePath: 'assets/images/해님달님.png', text: '해님달님'),
                BookInfo(imagePath: 'assets/images/인기도서3.png', text: '인기도서3'),
              ]),
              SizedBox(height: 20),
              _buildBookRow([
                BookInfo(imagePath: 'assets/images/인기도서4.png', text: '인기도서4'),
                BookInfo(imagePath: 'assets/images/인기도서5.png', text: '인기도서5'),
                BookInfo(imagePath: 'assets/images/인기도서6.png', text: '인기도서6'),
              ]),
              SizedBox(height: 20),
              _buildBookRow([
                BookInfo(imagePath: 'assets/images/도와줘,브루너.png', text: '도와줘, 브루너'),
                BookInfo(imagePath: 'assets/images/봄날의즐거운모자대회.png', text: '봄날의 즐거운 모자 대회'),
                BookInfo(imagePath: 'assets/images/변신요가.png', text: '변신 요가'),
              ]),
              SizedBox(height: 20),
              _buildBookRow([
                BookInfo(imagePath: 'assets/images/인기도서1.png', text: '인기도서1'),
                BookInfo(imagePath: 'assets/images/인기도서2.png', text: '인기도서2'),
                BookInfo(imagePath: 'assets/images/친구의전설.png', text: '친구의 전설'),
              ]),
              SizedBox(height: 20), // 스크롤의 마지막 간격
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookRow(List<BookInfo> books) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: books.map((book) {
        return _buildBookImage(book.imagePath, book.text);
      }).toList(),
    );
  }

  Widget _buildBookImage(String imagePath, String text) {
    return Column(
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
        SizedBox(height: 5), // 텍스트와 이미지 사이의 간격 조절
        Text(
          text,
          style: TextStyle(fontSize: 12), // 텍스트의 크기 조절
        ),
      ],
    );
  }
}

class BookInfo {
  final String imagePath;
  final String text;

  BookInfo({required this.imagePath, required this.text});
}
