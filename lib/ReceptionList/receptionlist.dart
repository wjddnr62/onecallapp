import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onecallapp/Model/receptionListData.dart';
import 'package:onecallapp/ReceptionList/receptiondetail.dart';
import 'package:onecallapp/Utils/color.dart';
import 'package:onecallapp/Utils/numberFormat.dart';
import 'package:onecallapp/Utils/whiteSpace.dart';

class ReceptionList extends StatefulWidget {
  @override
  _ReceptionList createState() => _ReceptionList();
}

class RadioGroup {
  String text;
  int idx;

  RadioGroup({this.text, this.idx});
}

class _ReceptionList extends State<ReceptionList> {
  List<ReceptionListData> _receptionData = List();

  List<String> testNumberAddress = List();
  List<String> testLoadAddress = List();
  List<String> testCustomerPhone = List();
  List<int> testPaymentAmount = List();
  List<int> testDeliveryAmount = List();
  List<int> testPaymentType = List();
  int testAllPaymentAmount = 0;
  int testAllDeliveryAmount = 0;

  @override
  void initState() {
    super.initState();

    testNumberAddress
      ..add("신흥동 5587")
      ..add("신흥동 5587")
      ..add("신흥동 5587")
      ..add("신흥동 5587")
      ..add("신흥동 5587");
    testLoadAddress
      ..add("산성대로285번길 25-15")
      ..add("산성대로285번길 25-15")
      ..add("산성대로285번길 25-15")
      ..add("산성대로285번길 25-15")
      ..add("산성대로285번길 25-15");
    testCustomerPhone
      ..add("010-1234-5678")
      ..add("010-1234-5678")
      ..add("010-1234-5678")
      ..add("010-1234-5678")
      ..add("010-1234-5678");
    testPaymentAmount
      ..add(20900)
      ..add(21500)
      ..add(20900)
      ..add(21500)
      ..add(21500);
    testDeliveryAmount..add(3100)..add(3200)..add(3100)..add(3200)..add(3200);
    testPaymentType..add(0)..add(2)..add(1)..add(3)..add(2);

    for (int i = 0; i < testPaymentAmount.length; i++) {
      testAllPaymentAmount += testPaymentAmount[i];
    }

    for (int i = 0; i < testDeliveryAmount.length; i++) {
      testAllDeliveryAmount += testDeliveryAmount[i];
    }

    testAllDeliveryAmount -= 50 * testDeliveryAmount.length;

    _receptionData
      ..add(ReceptionListData(
          assignmentTime: 20,
          receptionTime: 12,
          businessName: "(공유주방) 열혈분식",
          customerPhone: "010-1234-5678",
          numberAddress: "신흥동 2572",
          loadAddress: "산성대로269번길 10",
          mainTel: "031-123-4567",
          mainPhone: "010-1234-5678",
          mainNumberAddress: "신흥동 2572",
          mainLoadAddress: "산성대로283번길 25-15",
          paymentAmountAll: 25000,
          paymentAmount: 25000,
          deliveryType: 0,
          deliveryAmount: 3500,
          paymentType: 0))
      ..add(ReceptionListData(
          assignmentTime: 20,
          receptionTime: 10,
          businessName: "(공유주방) 국민닭발",
          customerPhone: "010-1234-5678",
          numberAddress: "신흥동 2572",
          loadAddress: "산성대로269번길 10",
          mainTel: "031-123-4567",
          mainPhone: "010-1234-5678",
          mainNumberAddress: "신흥동 2572",
          mainLoadAddress: "산성대로283번길 25-15",
          paymentAmountAll: 17000,
          paymentAmount: 17000,
          deliveryType: 0,
          deliveryAmount: 3200,
          paymentType: 0))
      ..add(ReceptionListData(
          assignmentTime: 20,
          receptionTime: 8,
          businessName: "(공유주방) 청춘키친",
          customerPhone: testCustomerPhone,
          numberAddress: testNumberAddress,
          loadAddress: testLoadAddress,
          mainTel: "031-123-4567",
          mainPhone: "010-1234-5678",
          mainNumberAddress: "신흥동 2572",
          mainLoadAddress: "산성대로283번길 25-15",
          paymentAmountAll: testAllPaymentAmount,
          paymentAmount: testPaymentAmount,
          deliveryType: 1,
          deliveryAmount: testDeliveryAmount,
          paymentType: testPaymentType))
      ..add(ReceptionListData(
          assignmentTime: 20,
          receptionTime: 2,
          businessName: "(공유주방) 국민닭발",
          customerPhone: "010-1234-5678",
          numberAddress: "신흥동 2572",
          loadAddress: "산성대로269번길 10",
          mainTel: "031-123-4567",
          mainPhone: "010-1234-5678",
          mainNumberAddress: "신흥동 2572",
          mainLoadAddress: "산성대로283번길 25-15",
          paymentAmountAll: 17000,
          paymentAmount: 17000,
          deliveryType: 0,
          deliveryAmount: 3200,
          paymentType: 0))
      ..add(ReceptionListData(
          assignmentTime: 20,
          receptionTime: 14,
          businessName: "(공유주방) 국민닭발",
          customerPhone: "010-1234-5678",
          numberAddress: "신흥동 2572",
          loadAddress: "산성대로269번길 10",
          mainTel: "031-123-4567",
          mainPhone: "010-1234-5678",
          mainNumberAddress: "신흥동 2572",
          mainLoadAddress: "산성대로283번길 25-15",
          paymentAmountAll: 19000,
          paymentAmount: 19000,
          deliveryType: 0,
          deliveryAmount: 3300,
          paymentType: 0))
      ..add(ReceptionListData(
          assignmentTime: 20,
          receptionTime: 14,
          businessName: "(공유주방) 국민닭발",
          customerPhone: "010-1234-5678",
          numberAddress: "신흥동 2572",
          loadAddress: "산성대로269번길 10",
          mainTel: "031-123-4567",
          mainPhone: "010-1234-5678",
          mainNumberAddress: "신흥동 2572",
          mainLoadAddress: "산성대로283번길 25-15",
          paymentAmountAll: 19000,
          paymentAmount: 19000,
          deliveryType: 0,
          deliveryAmount: 3300,
          paymentType: 0));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemBuilder: (context, idx) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReceptionDetail(
                receptionListData: _receptionData[idx],
              )
            ));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 40,
                          color: _receptionData[idx].deliveryType == 0
                              ? black
                              : Colors.blueAccent,
                          child: Center(
                            child: Text(
                              _receptionData[idx].receptionTime.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: white,
                        ),
                        Container(
                          height: 40,
                          color: _receptionData[idx].deliveryType == 0
                              ? greyB
                              : Colors.blueAccent,
                          child: Center(
                            child: Text(
                              _receptionData[idx].assignmentTime.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                  fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
//                  height: MediaQuery.of(context).size.height,
                    color: white,
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 80,
                      color: _receptionData[idx].deliveryType == 0
                          ? black
                          : Colors.blueAccent,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _receptionData[idx].businessName,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: white,
                                  fontWeight: FontWeight.bold),
                            ),
                            whiteSpaceH(5),
                            Row(
                              children: <Widget>[
                                Text(
                                  _receptionData[idx].deliveryType == 0
                                      ? _receptionData[idx].numberAddress
                                      : "${_receptionData[idx].numberAddress[0]}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                ),
                                _receptionData[idx].deliveryType == 1
                                    ? Text(
                                  " 외 ${_receptionData[idx].numberAddress.length - 1}건",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold),
                                )
                                    : Container()
                              ],
                            ),
                            whiteSpaceH(5),
                            Row(
                              children: <Widget>[
                                Icon(Icons.phone, color: white,),
                                Text(
                                  _receptionData[idx].deliveryType == 0
                                      ? "${_receptionData[idx].customerPhone} (${numberFormat.format(_receptionData[idx].paymentAmountAll)})"
                                      : "${_receptionData[idx].customerPhone[0]} (${numberFormat.format(testAllPaymentAmount)})",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    color: white,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 80,
                      color: _receptionData[idx].deliveryType == 0
                          ? black
                          : Colors.blueAccent,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        child: _receptionData[idx].deliveryType == 0
                            ? RaisedButton(
                          onPressed: () {
                            print("지도");
                          },
                          color: white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
//                                height: MediaQuery.of(context).size.height,
                            color: white,
                            child: Center(
                              child: Text(
                                "지도",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                            : Center(
                          child: Text(
                            "묶음배달",
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 1,
                color: white,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                color: greyB,
                child: Stack(
                  children: <Widget>[
                    _receptionData[idx].deliveryType == 0
                        ? Positioned.fill(
                        left: 5,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${_receptionData[idx].loadAddress}",
                            style: TextStyle(color: black, fontSize: 14),
                          ),
                        ))
                        : Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${_receptionData[idx].loadAddress.length}건",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                        )),
                    Positioned.fill(
                        right: 5,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            _receptionData[idx].deliveryType == 0
                                ? "${numberFormat.format(_receptionData[idx].deliveryAmount)}"
                                : "${numberFormat.format(testAllDeliveryAmount)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.redAccent),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      },
      shrinkWrap: true,
      itemCount: _receptionData.length,
    );
  }
}
