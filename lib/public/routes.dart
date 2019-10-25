import 'package:onecallapp/CompleteList/completedetail.dart';
import 'package:onecallapp/CompleteList/completelist.dart';
import 'package:onecallapp/Home/home.dart';
import 'package:onecallapp/Map/maplocation.dart';
import 'package:onecallapp/ProgressList/progressdetail.dart';
import 'package:onecallapp/ProgressList/progresslist.dart';
import 'package:onecallapp/ReceptionList/receptiondetail.dart';
import 'package:onecallapp/ReceptionList/receptionlist.dart';

final routes = {
  "/Home": (context) => Home(),
  "/ReceptionList": (context) => ReceptionList(),
  "/ReceptionDetail": (context) => ReceptionDetail(),
  "/ProgressList": (context) => ProgressList(),
  "/ProgressDetail": (context) => ProgressDetail(),
  "/CompleteList": (context) => CompleteList(),
  "/CompleteDetail": (context) => CompleteDetail(),
  "/MapLocation": (context) => MapLocation(),
};
