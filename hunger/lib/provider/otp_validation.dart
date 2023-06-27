import 'package:flutter/cupertino.dart';
import 'package:hunger/repository/otp_repository.dart';

class OtpValidation with ChangeNotifier{
  final OtpRepository _repository = OtpRepository();
  String _otp = "";
  String get otp => _otp;
   bool _status = false;
   bool get status=> _status;

  //send otp on email
  void sendOtp(
      {String appName = 'hunger',
      String appEmail = 'mdashiqhossain6@gmail.com',
      required String userEmail,
      int otpLength = 6,
      String type = 'digits'}) {
    String url =
        'https://flutter.rohitchouhan.com/email-otp/v3.php?app_name=$appName&app_email=$appEmail&user_email=$userEmail&otp_length=$otpLength&type=$type';
    _repository.getOtpResponse(url: url).then((value){
      debugPrint("value : ${value.otp}");
      _otp = value.otp.toString();
      _status = value.status!;
      notifyListeners();
    });
  }

}
