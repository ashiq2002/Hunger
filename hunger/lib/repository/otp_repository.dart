import 'package:hunger/data/network/api_dao.dart';

import '../data/network/api_services.dart';
import '../model/otp_response.dart';

class OtpRepository{
  final ApiDao _apiDao = ApiServices();

  //getting the otp response
  Future<OtpResponse> getOtpResponse({required String url}) async {
    try{
      var result = await _apiDao.getApi(url: url);
      return otpResponseFromJson(result);
    }catch(e){
      rethrow;
    }
  }
}