import 'package:onecallapp/Model/receptionListData.dart';

class DataRoutes {
  static final DataRoutes _dataRoutes = DataRoutes._internal();

  factory DataRoutes() {
    return _dataRoutes;
  }

  DataRoutes._internal();

  List<ReceptionListData> _saveData;

  List<ReceptionListData> get saveData => _saveData;

  set saveData(List<ReceptionListData> value) {
    _saveData = value;
  }

}