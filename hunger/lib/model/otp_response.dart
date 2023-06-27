import 'dart:convert';
/// status : true
/// otp : "007045"

OtpResponse otpResponseFromJson(String str) => OtpResponse.fromJson(json.decode(str));
String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());
class OtpResponse {
  OtpResponse({
      bool? status, 
      String? otp,}){
    _status = status;
    _otp = otp;
}

  OtpResponse.fromJson(dynamic json) {
    _status = json['status'];
    _otp = json['otp'];
  }
  bool? _status;
  String? _otp;
OtpResponse copyWith({  bool? status,
  String? otp,
}) => OtpResponse(  status: status ?? _status,
  otp: otp ?? _otp,
);
  bool? get status => _status;
  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['otp'] = _otp;
    return map;
  }

}