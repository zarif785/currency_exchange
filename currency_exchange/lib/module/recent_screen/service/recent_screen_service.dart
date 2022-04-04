import 'dart:async';

import 'package:currency_exchange/model/recentModel.dart';
import 'package:currency_exchange/module/recent_screen/gateway/recent_screen_gateway.dart';
import 'package:flutter/cupertino.dart';

mixin RecentScreenService<T extends StatefulWidget> on State<T>{


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      getRecentConversions();
    });
  }


  StreamController<PageState> _recentListStreamController =
  StreamController.broadcast();

  Stream<PageState> get recentListStream => _recentListStreamController.stream;

  Sink<PageState>? get _recentListSink =>
      !_recentListStreamController.isClosed
          ? _recentListStreamController.sink
          : null;

  void getRecentConversions(){

    RecentScreenGateway.getRecentConversion().then((value) {
      if(value.isSuccess==true){
          _recentListSink?.add(DataLoadedState(value.data!));
      }
    });

  }

}
abstract class PageState{}

class LoadingState extends PageState {}

class EmptyState extends PageState {}

class DataLoadedState extends PageState {
  final RecentList data;
  DataLoadedState(this.data);
}