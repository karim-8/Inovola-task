import 'package:involatask/models/data_response.dart';
import 'package:involatask/web_services/endpoints.dart';
import 'package:involatask/web_services/http_client.dart';

class DataRepository {
  const DataRepository();

  Future<DataModel> fetchData() async {
    try {
      final response = await HttpClient.getInstance().get(EndPoints.getData);
      DataModel dataModel = DataModel.fromJson(response.data);
      return dataModel;
    } catch (err) {
      print(err);
    }
  }
}
