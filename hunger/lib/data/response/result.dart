import 'package:hunger/data/response/status.dart';

class Result<T>{
  Status? status;
  T? data;
  String? message;

  Result(this.status, this.data, this.message);

  Result.initState():status = Status.initial;
  Result.loadingState():status = Status.loading;
  Result.successState(this.data):status = Status.success;
  Result.errorState(this.message):status = Status.error;
}