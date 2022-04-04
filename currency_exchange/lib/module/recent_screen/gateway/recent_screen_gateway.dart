import 'package:currency_exchange/model/recentModel.dart';

import '../../../common/core/server.dart';
import '../../../model/ActionResult.dart';

mixin RecentScreenGateway{

  static Future<ActionResult<RecentList>> getRecentConversion(){

    return Server.instance.getRequest(url: 'recent').then((value){
      return ActionResult<RecentList>.fromServerResponse(
          response: value,
          generateData: (x)=> RecentList.fromJsonList(x)
      );
    });

  }

}