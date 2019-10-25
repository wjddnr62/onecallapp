import 'package:flutter/material.dart';
import 'package:onecallapp/Utils/color.dart';
import 'package:onecallapp/Utils/whiteSpace.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
//      height: MediaQuery.of(context).size.height,
      color: black,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              color: white,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: Text(
                "현재상태 : 출근",
                style: TextStyle(
                    fontSize: 16, color: black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                whiteSpaceW(5),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: white,
                    child: Center(
                      child: Text(
                        "내역조회",
                        style: TextStyle(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                whiteSpaceW(5),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: white,
                    child: Center(
                      child: Text(
                        "메 세 지",
                        style: TextStyle(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                whiteSpaceW(5),
              ],
            ),
          ),
          whiteSpaceH(5),
          Expanded(
            child: Row(
              children: <Widget>[
                whiteSpaceW(5),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: white,
                    child: Center(
                      child: Text(
                        "카드APP 다운로드",
                        style: TextStyle(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                whiteSpaceW(5),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: white,
                    child: Center(
                      child: Text(
                        "카드내역",
                        style: TextStyle(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                whiteSpaceW(5),
              ],
            ),
          ),
          whiteSpaceH(5),
          Expanded(
            child: Row(
              children: <Widget>[
                whiteSpaceW(5),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: white,
                    child: Center(
                      child: Text(
                        "계좌 출금요청",
                        style: TextStyle(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                whiteSpaceW(5),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: white,
                    child: Center(
                      child: Text(
                        "환경설정",
                        style: TextStyle(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                whiteSpaceW(5),
              ],
            ),
          ),
          whiteSpaceH(5)
        ],
      ),
    );
  }
}
