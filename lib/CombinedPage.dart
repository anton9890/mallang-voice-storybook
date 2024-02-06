import 'package:flutter/material.dart';
import 'signup.dart';

// StatefulWidget으로 이용약관 화면을 구현
class TermsOfService extends StatefulWidget {
  const TermsOfService({Key? key}) : super(key: key);

  // 이 위젯의 상태를 관리할 클래스 생성
  @override
  State<TermsOfService> createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  // 각 체크박스의 상태를 저장할 맵
  Map<int, bool> checkboxes = {0: false, 1: false, 2: false, 3: false, 4: false};

  // 상단 메뉴를 구성하는 위젯
  Widget _topMenu() {
    // 가로 방향으로 배열
    return Wrap(
      children: [
        _menuOne(menu: '전체 약관 모두 동의', index: 0),
        _menuOne(menu: '서비스 이용약관 동의(필수)', index: 1),
        _menuOne(menu: '개인정보 수집 및 이용동의(필수)', index: 2),
        _menuOne(menu: '품질 향상을 위한 이용자 데이터 수집(선택)', index: 3),
        _menuOne(menu: '마케팅 정보 수신 동의(선택)', index: 4),
      ],
    );
  }

  // _menuOne 항목을 구성하는 위젯
  Widget _menuOne({required String menu, required int index}) {
    // 사용자의 탭 동작을 처리하는 위젯
    return GestureDetector(
      onTap: () {
        // 체크박스를 클릭하면 상태를 토글
        setState(() {
          if (index ==0){
            // 첫 번째 체크박스를 클릭했을 때
            bool newValue = !checkboxes[index]!;
            checkboxes = {for (var key in checkboxes.keys) key: newValue!}; // 모든 체크박스 활성화
          }
          else {
            checkboxes[index] = !checkboxes[index]!;
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            // 체크박스 생성
            Checkbox(
              value: checkboxes[index],
              onChanged: (bool? value) {
                setState(() {
                  if (index == 0) {
                    // 첫 번째 체크박스를 클릭했을 때
                    checkboxes = {for (var key in checkboxes.keys) key: value!};  // 모든 체크박스 활성화
                  }
                  else{
                    checkboxes[index] = value!;
                  }
                });
              },
              activeColor: Colors.black, // 체크박스 활성화시 색상
            ),
            SizedBox(width: 8.0), // 체크박스와 텍스트 사이의 간격
            Expanded(
              child: Text(
                menu,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: checkboxes[index]!
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('말랑 서비스 약관 동의'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(padding: const EdgeInsets.all(10), child: _topMenu()),
            ),
          ),
          Container(
            height: 50.0,  // 컨테이너의 높이를 100픽셀로 설정
            width: double.infinity, // 컨테이너 가로길이를 꽉 차게 설정
            color: Colors.black,
            child: TextButton(
              child: const Text('동의하고 계속하기', style: TextStyle(color: Colors.white),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}