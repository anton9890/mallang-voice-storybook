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
  bool allAgreed = false;
  bool serviceAgreed = false;
  bool privacyAgreed = false;
  bool dataCollectionAgreed = false;
  bool marketingAgreed = false;

  // 이는 앱 화면을 빌드하는 메서드입니다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '약관 동의',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        // 화면의 메인 부분은 여러 텍스트와 체크박스로 구성되어 있습니다.
        // 각 체크박스는 해당 약관에 동의했는지 여부를 나타내는 불린 변수와 연결되어 있습니다.
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: Column(
              children: [
                Text('말랑에 오신 것을 환영합니다!',
                  style: TextStyle(
                    fontSize: 16,
                  ),),
                SizedBox(height: 10),
                Text('말랑 서비스를 이용하기 전에',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.withOpacity(0.5),
                  ),),
                Text('먼저 이용약관에 동의해주세요.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.withOpacity(0.5),
                  ),),
                SizedBox(height: 30),
                // '전체 약관 동의' 체크박스는 별도의 Contatiner에 포함되어 있습니다.
                _buildCheckboxWithContainer('전체 약관 동의', allAgreed, _handleAllAgreed),
                SizedBox(height: 20,),
                // 나머지 체크박스들은 Column 내에 포함되어 있습니다.
                _buildTermsCheckboxes(),
              ],
            ),
          ),
        ),
        // 하단에는 '다음' 버튼이 있습니다.
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              // '전체 약관 동의'가 선택되었거나
              // '서비스 이용약관 동의'와 '개인정보 수집 및 이용동의'가 모두 선택되었는지 확인합니다.
              if (allAgreed || (serviceAgreed && privacyAgreed)) {
                // 조건이 충족되었다면 다음 페이지로 이동합니다.
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
              } else {
                // 조건이 충족되지 않았다면 경고 메시지를 보여줍니다.
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text('모든 필수 약관에 동의해주세요.',
                        textAlign: TextAlign.center,),
                      actions: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            child: Text('확인',
                              style: TextStyle(
                                  color: Colors.black
                              ),),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                      backgroundColor: Colors.white,
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              backgroundColor: Colors.white38,
              surfaceTintColor: Colors.white38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('다음', style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  // 이는 주어진 제목, 상태, 그리고 변경 처리 함수를 가진 체크박스를 빌드합니다.
  // 이 체크박스는 별도의 Container에 포함되어 있습니다.
  Widget _buildCheckboxWithContainer(String title, bool value, ValueChanged<bool?> onChanged) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.withOpacity(0.05),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: value ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.black,
      ),
    );
  }

  // 이는 주어진 제목, 상태, 그리고 변경 처리 함수를 가진 체크박스를 빌드합니다.
  Widget _buildCheckbox(String title, bool value, ValueChanged<bool?> onChanged) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: value ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.black,
    );
  }

  // 이는 각각의 체크박스들을 빌드합니다.
  Widget _buildTermsCheckboxes() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          _buildCheckbox(
              '[필수] 서비스 이용약관 동의', serviceAgreed, _handleServiceAgreed),
          SizedBox(height: 20),
          _buildCheckbox(
              '[필수] 개인정보 수집 및 이용동의', privacyAgreed, _handlePrivacyAgreed),
          SizedBox(height: 20),
          _buildCheckbox('[선택] 품질 향상을 위한 이용자 데이터 수집', dataCollectionAgreed,
              _handleDataCollectionAgreed),
          SizedBox(height: 20),
          _buildCheckbox(
              '[선택] 마케팅 정보 수신 동의', marketingAgreed, _handleMarketingAgreed),
        ],
      ),
    );
  }

  // 이는 각 체크박스의 상태 변화를 처리하는 메서드들입니다.
  void _handleAllAgreed(bool? value) {
    setState(() {
      allAgreed = value!;
      serviceAgreed = value;
      privacyAgreed = value;
      dataCollectionAgreed = value;
      marketingAgreed = value;
    });
  }

  void _handleServiceAgreed(bool? value) {
    setState(() {
      serviceAgreed = value!;
    });
  }

  void _handlePrivacyAgreed(bool? value) {
    setState(() {
      privacyAgreed = value!;
    });
  }

  void _handleDataCollectionAgreed(bool? value) {
    setState(() {
      dataCollectionAgreed = value!;
    });
  }

  void _handleMarketingAgreed(bool? value) {
    setState(() {
      marketingAgreed = value!;
    });
  }
}