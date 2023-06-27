import 'dart:io';

import 'package:http/http.dart';
import 'package:hunger/data/network/api_dao.dart';
import 'package:http/http.dart' as http;

import '../app_exception.dart';

class ApiServices extends ApiDao{
  @override
  Future getApi({required String url}) async {
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = getResponse(response);

    }on SocketException{
      throw FetchDataException("No Internet connection");
    }
    return responseJson;
  }//get api response

  //return api response
  dynamic getResponse(Response response){
    switch(response.statusCode){
      case 200:
        return response.body;

      case 400:
        throw BadRequestException(response.body.toString());

      case 404:
        throw UnauthorisedException(response.body.toString());

      default:
        throw FetchDataException("Error accrued while communicating with server\nStatus code : ${response.statusCode.toString()}");
    }
  }

}