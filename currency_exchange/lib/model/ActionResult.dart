

import '../common/core/server.dart';

///Name: Md. Abdur Rouf
///Email: official.rouf69nb@gmail.com
///Created at: Dec 28, 2021


class ActionResult<T>{
  late bool isSuccess;
  late String message;
  late T? data;
  ActionResult({required this.isSuccess,required this.message, this.data});

  ActionResult.fromServerResponse({required ServerResponse response,required T Function(dynamic data) generateData}){
    this.isSuccess = response.success;
    this.message = response.message;
    this.data = isSuccess ? generateData(response.data):null;
  }

  ActionResult.fromConvertorResponse({required ServerResponse response,required T Function(dynamic data) generateData}){
    this.isSuccess = response.success;
    this.message = response.message;
    this.data = isSuccess ? generateData(response.data):null;
  }


}
