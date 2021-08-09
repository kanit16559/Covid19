
import 'package:covid19/constant/constant.dart';
import 'package:covid19/models/covid19_model.dart';
import 'package:dio/dio.dart';

class Covid19Service {


  Constant constant = Constant();
  Future<Covid19Model?> getAPICovid19() async {
    Dio dio = Dio();
    Response response = await dio.get(constant.url);
    if(response.statusCode == 200){
      Map<String, dynamic> body = response.data as Map<String, dynamic>;
      // Covid19Model covid19model = Covid19Model.fromJson(body);
      return Covid19Model.fromJson(body);
    }else{
      print('Error!!!');
      return null;
    }
  }

}