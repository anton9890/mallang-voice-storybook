import 'package:flutter/material.dart';
import 'package:mallang/main.dart';

class TermsOfService extends StatefulWidget {
  const TermsOfService({Key? key}) : super(key: key);

  @override
  State<TermsOfService> createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  Map<int, bool> checkboxes = {0: false, 1: false, 2: false, 3: false, 4: false};

  Widget _topMenu() {
    return Wrap(
      children: [
        _menuOne(
          menu: '서비스 이용약관 동의(필수)',
          index: 0,
        ),
        _menuOne(
          menu: '개인정보 수집 및 이용동의(필수)',
          index: 1,
        ),
        _menuOne(
          menu: '품질 향상을 위한 이용자 데이터 수집(선택)',
          index: 2,
        ),
        _menuOne(
          menu: '마케팅 정보 수신 동의(선택)',
          index: 3,
        ),
        _menuOne(
          menu: '마케팅 정보 수신 동의(선택)',
          index: 4,
        ),
      ],
    );
  }

  Widget _menuOne({required String menu, required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          checkboxes[index] = !checkboxes[index]!;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Checkbox(
              value: checkboxes[index],
              onChanged: (bool? value) {
                setState(() {
                  checkboxes[index] = value!;
                });
              },
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                menu,
                style: TextStyle(
                  color: checkboxes[index]!
                      ? const Color(0xffe53154)
                      : Colors.black,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(10), child: _topMenu()),
          ],
        ),
      ),
    );
  }
}

