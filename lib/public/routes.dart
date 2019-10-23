import 'package:onecallapp/Home/home.dart';
import 'package:onecallapp/Map/maplocation.dart';
import 'package:onecallapp/ReceptionList/receptiondetail.dart';
import 'package:onecallapp/ReceptionList/receptionlist.dart';

final routes = {
  "/Home": (context) => Home(),
  "/ReceptionList": (context) => ReceptionList(),
  "/ReceptionDetail": (context) => ReceptionDetail(),
  "/MapLocation": (context) => MapLocation(),
};
