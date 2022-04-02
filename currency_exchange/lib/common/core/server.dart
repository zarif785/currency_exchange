///Name: Md. Abdur Rouf
///Email: official.rouf69nb@gmail.com
///Created at: Dec 14, 2021

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart' as _io;
import 'package:http/http.dart' as http;

class Server{
  static final Server _s = Server._();
  late _io.IOClient _client;
  static Server get instance=> _s;
  Server._(){
    HttpClient _httpClient = HttpClient();
    _httpClient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    _client = _io.IOClient(_httpClient);
  }

  void dispose(){
    _client.close();
    _sessionExpireStreamController.close();
  }

  final StreamController<String> _sessionExpireStreamController = StreamController.broadcast();
  static String get host => "http://currency-converter.rubai.me";

  Future<ServerResponse> postRequest({required String url, required Map postData,}) async {
    try {
      var body = json.encode(postData);
      var response = await _client.post(
        Uri.parse("$host/api/$url"),
        headers: {"Accept": "application/json", "Content-Type": "application/json",},
        body: body,
      );
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $body");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");

      var jsonData = jsonDecode(response.body);
      return ServerResponse.fromJson(jsonData);
    }
    on SocketException catch(_){
      return ServerResponse(success: false, data: _, message:  "Request failed!. Check internet connection.");
    }
    on Exception catch(_)
    {
      return ServerResponse(success: false, data: _, message: "Request failed! Unknown error occurred.");
    }
  }

  Future<dynamic> getRequest({required String url,String? token}) async {
    try {
      var response = await _client.get(
          Uri.parse("$host/api/$url"),
          headers: {"Accept": "application/json", "Content-Type":"application/json",}
      );

      debugPrint("REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");

      var jsonData = jsonDecode(response.body);
      return ServerResponse.fromJson(jsonData);
    }
    on SocketException catch(_){
      return ServerResponse(success: false, data: _, message: "Request failed!. Check internet connection.");
    }
    on Exception catch(_)
    {
      return ServerResponse(success: false, data: _, message: "Request failed! Unknown error occurred.");
    }
  }

  Future<dynamic> getRequest2({required String url,String? token}) async {
    try {
      var response = await _client.get(
          Uri.parse(url),
          headers: {"Accept": "application/json", "Content-Type":"application/json",}
      );

      debugPrint("REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");

      var jsonData = jsonDecode(response.body);
      return ServerResponse.fromJsonV2(jsonData);
    }

    on SocketException catch(_){
      return ServerResponse(success: false, data: _, message: "Request failed!. Check internet connection.");
    }
    on Exception catch(_)
    {
      return ServerResponse(success: false, data: _, message: "Request failed! Unknown error occurred.");
    }
  }
  // Future<dynamic> deleteRequest({required String url,String? token}) async {
  //   try {
  //     var response = await _client.delete(
  //         Uri.parse("$host/api/$url"),
  //         headers: {"Accept": "application/json", "Content-Type":"application/json", "Authorization": "${App.currentSession.tokenType} ${App.currentSession.accessToken}"}
  //     );
  //
  //     debugPrint("REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
  //
  //     var jsonData = jsonDecode(response.body);
  //     return ServerResponse.fromJson(jsonData);
  //   }
  //   on SocketException catch(_){
  //     return ServerResponse(success: false, data: _, message: "Request failed!. Check internet connection.");
  //   }
  //   on Exception catch(_)
  //   {
  //     return ServerResponse(success: false, data: _, message: "Request failed! Unknown error occurred.");
  //   }
  // }

  // void uploadFile({required String url, required File file,required void Function(ServerResponse response) onComplete}) async {
  //   try {
  //
  //     var request =  http.MultipartRequest("POST", Uri.parse("$host/api/$url"));
  //     request.headers.addAll({"Accept": "application/json", "Authorization": "${App.currentSession.tokenType} ${App.currentSession.accessToken}"});
  //     var attachedFile = await http.MultipartFile.fromPath('image', file.path,contentType: MediaType('image', 'jpeg'));
  //     request.files.add(attachedFile);
  //
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       response.stream.transform(utf8.decoder).listen((value) {
  //         var jsonData = jsonDecode(value);
  //         onComplete(ServerResponse.fromJson(jsonData));
  //       });
  //     }
  //     else if(response.statusCode != 401) {
  //       if(!_sessionExpireStreamController.isClosed){
  //         _sessionExpireStreamController.sink.add("Session expired!");
  //       }
  //       onComplete(ServerResponse(success: false, data: "", message: "Upload failed! Unauthorized user."));
  //     }else{
  //       onComplete(ServerResponse(success: false, data: "", message: "Upload failed! Unknown error occurred."));
  //     }
  //   }
  //   on SocketException catch(_){
  //     onComplete(ServerResponse(success: false, data: _, message:  "Request failed! Check internet connection."));
  //   }
  //   on Exception catch(_)
  //   {
  //     onComplete(ServerResponse(success: false, data: _, message: "Request failed! Unknown error occurred."));
  //   }
  // }
}

class ServerResponse {
  dynamic data;
  late String message;
  late bool success;

  ServerResponse({this.data, required this.message, required this.success});

  ServerResponse.fromJson(Map<String, dynamic> json) {
    message = json['message']??"";
    data = json['data'];
    success = json['status']??false;

  }

  ServerResponse.fromJsonV2(Map<String, dynamic> json) {
    message = json['message']??"";
    data = json;

    if(json['status']=="success"){
      success = true;
    }
    else{
      success = false;
    }
    print(success);

  }
}

