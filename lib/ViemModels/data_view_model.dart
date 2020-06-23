import 'package:flutter/cupertino.dart';
import 'package:involatask/Repository/data_repo.dart';
import 'package:involatask/models/data_response.dart';

class DataViewModel with ChangeNotifier {
  DataRepository _dataRepository = DataRepository();

  DataModel _data;

  ///Getter
  DataModel get data => _data;

  ///Adding data into object
  void addData(DataModel dataModel) {
    this._data = dataModel;
    notifyListeners();
  }

  ///fetch data through the repo class
  Future<bool> getData() async {
    try {
      DataModel response = await _dataRepository.fetchData();
      this.addData(response);
      return true;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
