import 'package:flutter/material.dart';
import 'package:onecallapp/Map/maplocation.dart';
import 'package:onecallapp/Model/receptionListData.dart';
import 'package:onecallapp/Utils/color.dart';
import 'package:onecallapp/Utils/numberFormat.dart';
import 'package:onecallapp/Utils/whiteSpace.dart';
import 'package:permission_handler/permission_handler.dart';

class ReceptionDetail extends StatefulWidget {
  ReceptionListData receptionListData;

  ReceptionDetail({Key key, this.receptionListData}) : super(key: key);

  @override
  _ReceptionDetail createState() => _ReceptionDetail();
}

class _ReceptionDetail extends State<ReceptionDetail> {
  ReceptionListData receptionListData;

  @override
  void initState() {
    super.initState();

    receptionListData = widget.receptionListData;
  }

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

  // type = 0 (기사위치 -> 상점위치), type = 1 (기사위치 -> 도착위치), type = 2 (웹뷰 다음맵 길찾기 연결), type = 3 (현재 기사위치 -> 상점위치, 고객위치)
  mapViewMove(type, mainLoadAddress, loadAddress, List<String> loadAddressList) {
    permissionCheck().then((pass) {
      if (pass == true) {
        if (type == 0) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapLocation(
            mainLoadAddress: mainLoadAddress,
          )));
        } else if (type == 1) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapLocation(
            loadAddress: loadAddress,
          )));
        } else if (type == 2) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapLocation(
            loadAddress: loadAddress,
          )));
        } else if (type == 3) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapLocation(
            loadAddressList: loadAddressList,
          )));
        }
      } else {
        print("error");
      }
    });
  }

  // type : 0 = 상점 위치, 1 = 도착 위치, 2 = 네비
  locationButton(type, mainLoadAddress, loadAddress) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (type == 0) {
          } else if (type == 1) {
          } else if (type == 2) {
            mapViewMove(2, "", loadAddress, null);
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: type == 0
                  ? Colors.green
                  : type == 1
                      ? Colors.deepOrangeAccent
                      : type == 2 ? Colors.blueAccent : Colors.transparent),
          child: Center(
            child: Text(
              type == 0 ? "상점 위치" : type == 1 ? "도착 위치" : type == 2 ? "네비" : "",
              style: TextStyle(
                  color: black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  shopInfo(ReceptionListData data) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: white,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blueAccent,
          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "상점정보",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20, color: white),
                ),
              ),
              data.deliveryType == 1
                  ? Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 219, 219, 219),
                                    blurRadius: 2)
                              ],
                              color: Colors.green),
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              "상점 위치",
                              style: TextStyle(color: black),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: white,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  padding: EdgeInsets.only(left: 5),
                  color: greyW,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "상점명",
                      style: TextStyle(color: black, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                color: white,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  padding: EdgeInsets.only(left: 5),
                  color: black,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data.businessName,
                      style: TextStyle(
                          fontSize: 20,
                          color: white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: white,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 5, left: 5),
                  color: greyW,
                  child: Text(
                    "전화",
                    style: TextStyle(color: black, fontSize: 20),
                  ),
                ),
              ),
              Container(
                width: 1,
                color: white,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: black,
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 20,
                                height: 20,
                                color: white,
                              ),
                              whiteSpaceW(5),
                              Text(
                                data.mainTel,
                                style: TextStyle(color: white, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 20,
                                height: 20,
                                color: white,
                              ),
                              whiteSpaceW(5),
                              Text(
                                data.mainPhone,
                                style: TextStyle(color: white, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: white,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: greyW,
                  child: Text(
                    "상점주소",
                    style: TextStyle(color: black, fontSize: 20),
                  ),
                ),
              ),
              Container(
                width: 1,
                color: white,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: black,
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          data.mainNumberAddress,
                          style: TextStyle(fontSize: 20, color: white),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "(${data.mainLoadAddress})",
                          style: TextStyle(fontSize: 20, color: white),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: white,
        ),
      ],
    );
  }

  customerInfo(ReceptionListData data, idx) {
    int id = idx - 1;
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: white,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blueAccent,
          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
          child: Row(
            children: <Widget>[
              Text(
                data.deliveryType == 0 ? "고객정보" : "고객정보 (${idx.toString()})",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20, color: white),
              ),
              whiteSpaceW(5),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: white, width: 1),
                    borderRadius: BorderRadius.circular(5),
                    color: data.deliveryType == 0
                        ? (data.paymentType == 0
                            ? Colors.lightGreen
                            : data.paymentType == 1
                                ? Colors.indigo
                                : data.paymentType == 2
                                    ? Colors.redAccent
                                    : data.paymentType == 3
                                        ? Colors.deepPurple
                                        : Colors.transparent)
                        : (data.paymentType[id] == 0
                            ? Colors.lightGreen
                            : data.paymentType[id] == 1
                                ? Colors.indigo
                                : data.paymentType[id] == 2
                                    ? Colors.redAccent
                                    : data.paymentType[id] == 3
                                        ? Colors.deepPurple
                                        : Colors.transparent)),
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    data.deliveryType == 0
                        ? (data.paymentType == 0
                            ? "카드"
                            : data.paymentType == 1
                                ? "완불"
                                : data.paymentType == 2
                                    ? "현금"
                                    : data.paymentType == 3 ? "이체" : "")
                        : (data.paymentType[id] == 0
                            ? "카드"
                            : data.paymentType[id] == 1
                                ? "완불"
                                : data.paymentType[id] == 2
                                    ? "현금"
                                    : data.paymentType[id] == 3 ? "이체" : ""),
                    style: TextStyle(color: white),
                  ),
                ),
              ),
              data.deliveryType == 1
                  ? Expanded(
                      child: Container(),
                    )
                  : Container(),
              data.deliveryType == 1
                  ? Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 219, 219, 219),
                                    blurRadius: 2)
                              ],
                              color: Colors.deepOrangeAccent),
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              "도착 위치",
                              style: TextStyle(color: black),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              whiteSpaceW(5),
              data.deliveryType == 1
                  ? Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: GestureDetector(
                        onTap: () {
                          mapViewMove(2, "", data.loadAddress[idx], null);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 219, 219, 219),
                                    blurRadius: 2)
                              ],
                              color: Colors.blueAccent),
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              "네비",
                              style: TextStyle(color: black),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: white,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  padding: EdgeInsets.only(top: 5, left: 5),
                  color: greyW,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "목적지",
                      style: TextStyle(color: black, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                color: white,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  padding: EdgeInsets.only(left: 5),
                  color: black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          data.deliveryType == 0
                              ? data.numberAddress
                              : data.numberAddress[id],
                          style: TextStyle(color: white, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          data.deliveryType == 0
                              ? "(${data.loadAddress})"
                              : "(${data.loadAddress[id]})",
                          style: TextStyle(fontSize: 20, color: white),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 20,
                                height: 20,
                                color: white,
                              ),
                              whiteSpaceW(5),
                              Text(
                                data.deliveryType == 0
                                    ? data.customerPhone
                                    : data.customerPhone[id],
                                style: TextStyle(color: white, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: white,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 5, left: 5),
                  color: greyW,
                  child: Text(
                    "결제금액",
                    style: TextStyle(color: black, fontSize: 20),
                  ),
                ),
              ),
              Container(
                width: 1,
                color: white,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  color: black,
                  padding: EdgeInsets.only(left: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data.deliveryType == 0
                          ? "${numberFormat.format(data.paymentAmount)}원"
                          : "${numberFormat.format(data.paymentAmount[id])}원",
                      style: TextStyle(color: white, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: white,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  color: greyW,
                  child: Text(
                    "대행금액",
                    style: TextStyle(color: black, fontSize: 20),
                  ),
                ),
              ),
              Container(
                width: 1,
                color: white,
              ),
              Expanded(
                flex: 3,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: black,
                    padding: EdgeInsets.only(left: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data.deliveryType == 0
                            ? "${numberFormat.format(data.deliveryAmount)}원"
                            : "${numberFormat.format(data.deliveryAmount[id])}원",
                        style: TextStyle(fontSize: 20, color: white),
                      ),
                    )),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: white,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: black,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      color: receptionListData.deliveryType == 0
                          ? Colors.green
                          : Colors.blueAccent,
                      child: Center(
                        child: Text(
                          receptionListData.deliveryType == 0
                              ? "개별콜을 배정 요청하시겠습니까?"
                              : "묶음콜을 배정 요청하시겠습니까?",
                          style: TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: black,
                      child: Padding(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          children: <Widget>[
                            whiteSpaceH(10),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "잔액: ${numberFormat.format(150000)}",
                                    style:
                                        TextStyle(fontSize: 24, color: white),
                                  ),
                                ),
                                Text(
                                  "11초",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            whiteSpaceH(15),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () {
                                      print("예");
                                    },
                                    color: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 60,
                                      child: Center(
                                        child: Text(
                                          "예",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                whiteSpaceW(40),
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () {
                                      print("아니오");
                                    },
                                    color: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 60,
                                      child: Center(
                                        child: Text(
                                          "아니오",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: white),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            whiteSpaceH(15),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, idx) {
                          return receptionListData.deliveryType == 0
                              ? idx == 0
                                  ? Container(
                                      child: shopInfo(receptionListData))
                                  : Container(
                                      child:
                                          customerInfo(receptionListData, idx),
                                    )
                              : idx == 0
                                  ? Container(
                                      child: shopInfo(receptionListData))
                                  : Container(
                                      child:
                                          customerInfo(receptionListData, idx),
                                    );
                        },
                        shrinkWrap: true,
                        itemCount: receptionListData.deliveryType == 0
                            ? 2
                            : receptionListData.loadAddress.length + 1,
                      ),
                    ),
                    whiteSpaceH(25)
                  ],
                ),
              ),
              receptionListData.deliveryType == 0
                  ? Positioned.fill(
                      left: 5,
                      right: 5,
                      bottom: 30,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: <Widget>[
                            locationButton(0, receptionListData.mainLoadAddress, ""),
                            whiteSpaceW(15),
                            locationButton(1, "", receptionListData.loadAddress),
                            whiteSpaceW(15),
                            locationButton(2, "", receptionListData.loadAddress)
                          ],
                        ),
                      ))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
