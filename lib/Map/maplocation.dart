import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

class MapLocation extends StatefulWidget {
  int type; // type = 0 (기사위치 -> 상점위치), type = 1 (기사위치 -> 도착위치), type = 2 (웹뷰 다음맵 길찾기 연결), type = 3 (현재 기사위치 -> 상점위치, 고객위치)
  String mainLoadAddress; // 도착지 상점
  String loadAddress; // 도착지 고객
  List<String> loadAddressList; // 도착지 고객들

  MapLocation(
      {Key key,
      this.type,
      this.loadAddress,
      this.mainLoadAddress,
      this.loadAddressList})
      : super(key: key);

  @override
  _MapLocation createState() => _MapLocation();
}

class _MapLocation extends State<MapLocation> {
  int type;
  WebViewController _webViewController;
  String loadCompleteUrl;
  bool firstLoad = false;
  String url;
  var location = Location();
  bool loading = false;

  //https://map.kakao.com/?sName=서울시청&eName=서울고속터미널

  getLocation() async {
    try {
      await location.getLocation().then((value) async {
        final coordinates = Coordinates(value.latitude, value.longitude);
        var address =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        print("주소 : " +
            address.first.toString() +
            ", " +
            address.first.featureName +
            ", " +
            address.first.addressLine);
        setState(() {
          url =
              "https://map.kakao.com/?sName=${address.first.addressLine}&eName=${widget.loadAddress}";
        });
        print(url);
      });
      setState(() {
        loading = true;
      });
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        print(e.code);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    type = widget.type;
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        if (loadCompleteUrl == null) {
          Navigator.of(context).pop();
        } else {
          _webViewController.currentUrl().then((value) {
            print("url : " + value + ", " + loadCompleteUrl);
            if (value != loadCompleteUrl) {
              _webViewController.goBack();
            } else {
              Navigator.of(context).pop();
            }
          });
        }
        return null;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: loading == false
                ? Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      type == 0
                          ? Container()
                          : type == 1
                              ? Container()
                              : type == 2
                                  ? url != null
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: WebView(
                                            initialUrl:
                                                url,
                                            javascriptMode:
                                                JavascriptMode.unrestricted,
                                            onWebViewCreated: (_webController) {
                                              _webController.clearCache();
                                              _webViewController =
                                                  _webController;
                                            },
                                            onPageFinished: (url) {
                                              print("check : " + url);
                                              if (firstLoad == false) {
                                                loadCompleteUrl = url;
                                                firstLoad = true;
                                              }
                                            },
                                          ),
                                        )
                                      : Container()
                                  : type == 3 ? Container() : Container()
                    ],
                  ),
          )),
    );
  }
}
