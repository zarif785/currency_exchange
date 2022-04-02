

import 'package:currency_exchange/model/ActionResult.dart';
import 'package:currency_exchange/model/Convertor.dart';
import 'package:currency_exchange/model/Currency.dart';

import '../../../common/core/server.dart';

mixin HomeScreenGateway{
  
  static Future<ActionResult<CurrencyList>> getCurrencyList(){
    
    return Server.instance.getRequest(url: 'currency/get').then((value){
        return ActionResult<CurrencyList>.fromServerResponse(
            response: value,
            generateData: (x)=> CurrencyList.fromJsonList(x)
        );
    });
    
  }


  static Future<ActionResult<ConvertorModel>> getConvertedData({required String from, required String to, required double amount}){

    return Server.instance.getRequest2(url: 'https://api.getgeoapi.com/v2/currency/convert?api_key=41a5c00289e5130d182d9441bdd51866b67e3af8&from=$from&to=$to&amount=$amount&format=json').then((value){
      return ActionResult<ConvertorModel>.fromConvertorResponse(
          response: value,
          generateData: (x)=> ConvertorModel.fromJson(x,to)
      );
    });

  }
}