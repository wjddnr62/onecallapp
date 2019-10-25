import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:onecallapp/CompleteList/completelist.dart';
import 'package:onecallapp/Map/maplocation.dart';
import 'package:onecallapp/ProgressList/progresslist.dart';
import 'package:onecallapp/ReceptionList/receptionlist.dart';
import 'package:onecallapp/Setting/settings.dart';
import 'package:onecallapp/Utils/color.dart';
import 'package:intl/intl.dart';
import 'package:onecallapp/Utils/dataRoutes.dart';
import 'package:onecallapp/Utils/numberFormat.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class RadioGroup {
  String text;
  int idx;

  RadioGroup({this.text, this.idx});
}

class _Home extends State<Home> {
  int selectTabId = 0;
  int money = 150000;

  DataRoutes _dataRoutes = DataRoutes();

  Map<PermissionGroup, PermissionStatus> permissions;

  Future<bool> permissionCheck() async {
    permissions = await PermissionHandler()
        .requestPermissions([PermissionGroup.location]);
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    print("check: " + permission.toString());
    bool pass = false;

    if (permission == PermissionStatus.granted) {
      pass = true;
    }

    return pass;
  }


  var location = Location();

  Future<LatLng> getLocation() async {
    LatLng latLng;

    await location.getLocation().then((value) {
      latLng = LatLng(value.latitude, value.longitude);
    });

    return latLng;
  }


  // type = 0 (기사위치 -> 상점위치), type = 1 (기사위치 -> 도착위치), type = 2 (웹뷰 다음맵 길찾기 연결), type = 3 (현재 기사위치 -> 상점위치, 고객위치)
  mapViewMove(
      type, mainLoadAddress, loadAddress, List<String> loadAddressList) async {
    permissionCheck().then((pass) {
      if (pass == true) {
        if (type == 3) {
          getLocation().then((value) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MapLocation(
                  type: 3,
                  loadAddressList: loadAddressList,
                  latLng: value,
                )));
          });
        }
      } else {
        print("error");
      }
    });
  }

  nonSelectTab(text) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (text == "접수") {
              selectTabId = 0;
            } else if (text == "진행") {
              selectTabId = 1;
            } else if (text == "완료") {
              selectTabId = 2;
            }
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          color: black,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  selectTab(text) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        color: Colors.blueAccent,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  int curretValue = 0;

  List<RadioGroup> _radioGroup = [
    RadioGroup(text: "출근", idx: 0),
    RadioGroup(text: "퇴근", idx: 1),
    RadioGroup(text: "식사중", idx: 2),
    RadioGroup(text: "화장실", idx: 3),
    RadioGroup(text: "휴식중", idx: 4),
    RadioGroup(text: "수리중", idx: 5),
  ];

  curretStatusSet() {
    return showDialog(
        context: context,
        child: Dialog(
          elevation: 0.0,
          child: Container(
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: black,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  padding: EdgeInsets.only(left: 5),
                  child: Center(
                    child: Text(
                      "현재상태 지정",
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                ListView.builder(
                  itemBuilder: (context, idx) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          curretValue = idx;
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(_radioGroup[idx].text, style: TextStyle(
                                  fontSize: 16, color: black
                                ),),
                              ),
                              curretValue == idx ? Icon(Icons.radio_button_checked) : Icon(Icons.radio_button_unchecked)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: _radioGroup.length,
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: black,
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Container(
          height: 80,
          child: Row(
            children: <Widget>[
              selectTabId == 0 ? selectTab("접수") : nonSelectTab("접수"),
              Container(
                color: white,
                width: 1,
                height: MediaQuery.of(context).size.height,
              ),
              selectTabId == 1 ? selectTab("진행") : nonSelectTab("진행"),
              Container(
                color: white,
                width: 1,
                height: MediaQuery.of(context).size.height,
              ),
              selectTabId == 2 ? selectTab("완료") : nonSelectTab("완료"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        elevation: 0.0,
        child: Container(
          height: 40,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        List<String> loadAddressList = List();
                        print("chekc : " + _dataRoutes.saveData.length.toString());
                        for (int i = 0; i < _dataRoutes.saveData.length; i++) {
                          if(_dataRoutes.saveData[i].deliveryType == 0) {
                            loadAddressList.add(_dataRoutes.saveData[i].loadAddress);
                          } else {
                            for (int j = 0; j < _dataRoutes.saveData[i].loadAddress.length; j++) {
                              loadAddressList.add(_dataRoutes.saveData[i].loadAddress[j]);
                            }
                          }
                        }

                        selectTabId == 1 ? mapViewMove(3, "", "", loadAddressList) : curretStatusSet();
                      },
                      child: Icon(
                        selectTabId == 1 ? Icons.location_on : Icons.drag_handle,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: white,
                width: 1,
                height: MediaQuery.of(context).size.height,
              ),
              Expanded(
                flex: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "잔액: ${numberFormat.format(money)}",
                    style: TextStyle(
                        fontSize: 16,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                color: white,
                width: 1,
                height: MediaQuery.of(context).size.height,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectTabId = 3;
                        });
                      },
                      child: Text(
                        "설정",
                        style: TextStyle(
                            fontSize: 16,
                            color: white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - (selectTabId == 3 ? 120 : 100),
          padding: EdgeInsets.only(top: 10, bottom: selectTabId == 3 ? 10 : 30),
          child: selectTabId == 0
              ? ReceptionList()
              : selectTabId == 1
                  ? ProgressList()
                  : selectTabId == 2 ? CompleteList() : selectTabId == 3 ? Settings() : Container(),
        ),
      ),
    );
  }
}
