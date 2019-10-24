import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onecallapp/Utils/color.dart';
import 'package:onecallapp/Utils/whiteSpace.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:math' show cos, sqrt, asin;

class MapLocation extends StatefulWidget {
  int type; // type = 0 (기사위치 -> 상점위치), type = 1 (기사위치 -> 도착위치), type = 2 (웹뷰 다음맵 길찾기 연결), type = 3 (현재 기사위치 -> 상점위치, 고객위치)
  String mainLoadAddress; // 도착지 상점
  String loadAddress; // 도착지 고객
  List<String> loadAddressList; // 도착지 고객들
  LatLng latLng;

  MapLocation(
      {Key key,
      this.type,
      this.loadAddress,
      this.mainLoadAddress,
      this.loadAddressList,
      this.latLng})
      : super(key: key);

  @override
  _MapLocation createState() => _MapLocation();
}

class _MapLocation extends State<MapLocation> {
  int type;
  String url;
  var location = Location();
  bool loading = false;
  static LatLng _latLng;
  List<LatLng> latLngs = List();
  GoogleMapController _controller;
  final Set<Marker> markers = {};
  final Set<Polyline> polylines = {};

//  distance() {
  // 거리 계산 메소드 이용
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

//    double totalDistance =
//    calculateDistance(37.457176, 126.702209, 37.490364, 126.723441);
//    print(totalDistance.toStringAsFixed(1));
//    // 결과값 ex) 4.1 (단위 : km);
//  }

  polylineAdd(LatLng latLng, LatLng latLng2) {
    final PolylineId polylineId = PolylineId("1");
    latLngs..add(latLng)..add(latLng2);

    setState(() {
      polylines.add(Polyline(
        polylineId: polylineId,
        width: 3,
        visible: true,
        points: latLngs,
        color: Colors.redAccent,
      ));
    });
  }

  markerAdd(LatLng latLng, LatLng latLng2) {
//    if (type == 0) {
//
//    } else if (type == 1) {
//
//    } else if (type == 3) {
//
//    }
    final MarkerId markerId = MarkerId("1");

    setState(() {
      markers.add(Marker(
        markerId: markerId,
        position: latLng2,
        infoWindow: InfoWindow(
          title:
              "${calculateDistance(latLng.latitude, latLng.longitude, latLng2.latitude, latLng2.longitude).toStringAsFixed(1)}km",
        ),
      ));
    });
  }

  getLocation() async {
    try {
      await location.getLocation().then((value) async {
        if (type == 0) {
          final query = widget.mainLoadAddress;
          await Geocoder.local.findAddressesFromQuery(query).then((value) {
            markerAdd(
                _latLng,
                LatLng(value.first.coordinates.latitude,
                    value.first.coordinates.longitude));
            polylineAdd(
                _latLng,
                LatLng(value.first.coordinates.latitude,
                    value.first.coordinates.longitude));
          });
        } else if (type == 1) {
          final query = widget.loadAddress;
          await Geocoder.local.findAddressesFromQuery(query).then((value) {
            markerAdd(
                _latLng,
                LatLng(value.first.coordinates.latitude,
                    value.first.coordinates.longitude));
            polylineAdd(
                _latLng,
                LatLng(value.first.coordinates.latitude,
                    value.first.coordinates.longitude));
          });
        } else if (type == 3) {}
//        var address =
//            await Geocoder.local.findAddressesFromQuery(widget.loadAddress);
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
    print("type : " + type.toString());
    _latLng = widget.latLng;
    getLocation();
  }

  static final CameraPosition _initPlex =
      CameraPosition(target: _latLng, zoom: 12);

  _currentLocation() async {
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 12.0,
      ),
    ));
  }

  googleMap() {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              80,
          child: GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            initialCameraPosition: _initPlex,
            zoomGesturesEnabled: true,
            markers: markers,
            polylines: polylines,
            onMapCreated:
                (GoogleMapController controller) {
              _controller = controller;
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Color.fromRGBO(0, 0, 0, 0.5),
          padding: EdgeInsets.all(5),
          child: Text(
            type == 0 ? widget.mainLoadAddress : type == 1 ? widget.loadAddress : "", style: TextStyle(
              color: Colors.yellowAccent
          ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            floatingActionButton: FloatingActionButton(
              onPressed: _currentLocation,
            child: Icon(Icons.gps_fixed),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              color: black,
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          color: black,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: (Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 5,),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: RaisedButton(
                                      onPressed: () {
                                        _controller.animateCamera(
                                          CameraUpdate.zoomOut(),
                                        );
                                      },
                                      color: Colors.blueAccent,
                                      child: Center(
                                        child: Text(
                                          "-",
                                          style: TextStyle(color: white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              whiteSpaceW(5),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: RaisedButton(
                                    onPressed: () {
                                      _controller.animateCamera(
                                        CameraUpdate.zoomIn(),
                                      );
                                    },
                                    color: Colors.blueAccent,
                                    child: Center(
                                      child: Text(
                                        "+",
                                        style: TextStyle(color: white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              whiteSpaceW(5),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                              ),
                              whiteSpaceW(5),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    color: Colors.lightGreenAccent,
                                    child: Center(
                                      child: Text(
                                        "닫기",
                                        style: TextStyle(color: white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              whiteSpaceW(5)
                            ],
                          )),
                        ),
                        type == 0
                            ? googleMap()
                            : type == 1
                                ? googleMap()
                                : type == 3 ? Container() : Container()
                      ],
                    ),
            )),
      ),
    );
  }
}
