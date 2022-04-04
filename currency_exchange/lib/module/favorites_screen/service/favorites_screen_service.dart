import 'dart:async';

import 'package:currency_exchange/model/Popular.dart';
import 'package:currency_exchange/module/favorites_screen/gateway/favorite_screen_gateway.dart';
import 'package:flutter/cupertino.dart';

mixin FavoriteScreenService<T extends StatefulWidget> on State<T>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      getPopularConversions();
    });
  }


  StreamController<PageState> _popularListStreamController =
  StreamController.broadcast();

  Stream<PageState> get popularListStream => _popularListStreamController.stream;

  Sink<PageState>? get _popularListSink =>
      !_popularListStreamController.isClosed
          ? _popularListStreamController.sink
          : null;

  void getPopularConversions(){

    FavoriteScreenGateway.getFavoriteConversion().then((value) {
      if(value.isSuccess==true){
        _popularListSink?.add(DataLoadedState(value.data!));
      }
    });

  }


}

abstract class PageState{}

class LoadingState extends PageState {}

class EmptyState extends PageState {}

class DataLoadedState extends PageState {
  final PopularList data;
  DataLoadedState(this.data);
}