import 'package:currency_exchange/model/Popular.dart';

import '../../../common/core/server.dart';
import '../../../model/ActionResult.dart';

mixin FavoriteScreenGateway{

  static Future<ActionResult<PopularList>> getFavoriteConversion(){

    return Server.instance.getRequest(url: 'popular').then((value){
      return ActionResult<PopularList>.fromServerResponse(
          response: value,
          generateData: (x)=> PopularList.fromJsonList(x)
      );
    });

  }

}