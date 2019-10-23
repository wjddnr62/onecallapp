import 'package:flutter/material.dart';
import 'package:onecallapp/Utils/color.dart';
import 'package:onecallapp/Utils/whiteSpace.dart';
import 'package:onecallapp/public/routes.dart';

void main() => runApp(MaterialApp(
      home: Login(),
      routes: routes,
      debugShowCheckedModeBanner: false,
    ));

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final _idController = TextEditingController();
  final _passController = TextEditingController();

  final _idFocus = FocusNode();
  final _passFocus = FocusNode();

  bool idSaveCheck = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5),
                child: Text(
                  "로고",
                  style: TextStyle(
                      fontSize: 30, color: black, fontWeight: FontWeight.bold),
                ),
              ),
              whiteSpaceH(50),
              Text(
                "Ver. 기사",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: black, fontSize: 20),
              ),
              whiteSpaceH(50),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                          child: TextFormField(
                            controller: _idController,
                            focusNode: _idFocus,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(_passFocus);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.person),
                              hintText: "아이디",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                          child: TextFormField(
                            controller: _passController,
                            focusNode: _passFocus,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.lock),
                                hintText: "비밀번호"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              whiteSpaceH(10),
              Row(
                children: <Widget>[
                  whiteSpaceW(30),
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: idSaveCheck,
                    onChanged: (value) {
                      setState(() {
                        idSaveCheck = value;
                      });
                    },
                  ),
                  Text(
                    "저장",
                    style: TextStyle(
                        fontSize: 14,
                        color: black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              whiteSpaceH(10),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/Home");
                  },
                  color: Color.fromARGB(255, 0, 176, 240),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Center(
                      child: Text(
                        "로그인",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
