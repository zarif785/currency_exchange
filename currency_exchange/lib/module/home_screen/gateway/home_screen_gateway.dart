

import 'package:currency_exchange/model/ActionResult.dart';
import 'package:currency_exchange/model/Convertor.dart';
import 'package:currency_exchange/model/Currency.dart';
import 'package:currency_exchange/model/recentModel.dart';

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


  static Future<ActionResult<RecentsModel>> setConvertedData(
      String currency_from,String currency_to,double amount_from,amount_to,int from_id, int to_id
      ) {
    return Server.instance.postRequest(
        url: 'recent',
        postData: {
          "from_id": from_id,
          "to_id": to_id,
          "currency_from": currency_from,
          "currency_to": currency_to,
          "amount_from": amount_from,
          "amount_to": amount_to,
        }
    ).then((value) {
      return ActionResult<RecentsModel>.fromServerResponse(
        response: value,
        generateData: (x) => RecentsModel.empty()
      );
    });
  }
}