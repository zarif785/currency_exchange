
import 'dart:async';

import 'package:currency_exchange/model/Convertor.dart';
import 'package:currency_exchange/model/Currency.dart';
import 'package:currency_exchange/module/home_screen/gateway/home_screen_gateway.dart';
import 'package:flutter/cupertino.dart';

mixin HomeScreenService<T extends StatefulWidget>on State<T>{


  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {

    });
  }

  StreamController<PageState> _currencyListStreamController =
  StreamController.broadcast();

  Stream<PageState> get currencyListStream => _currencyListStreamController.stream;

  Sink<PageState>? get _currencyListSink =>
      !_currencyListStreamController.isClosed
          ? _currencyListStreamController.sink
          : null;


  StreamController<String> _convertorStreamController =
  StreamController.broadcast();

  Stream<String> get convertorListStream => _convertorStreamController.stream;

  Sink<String>? get _convertorListSink =>
      !_convertorStreamController.isClosed
          ? _convertorStreamController.sink
          : null;

  void getCurrencyList()async{

    await HomeScreenGateway.getCurrencyList().then((value){

      if(value.isSuccess==true){

        _currencyListSink?.add(DataLoadedState(value.data!));

      }

    });

  }

  void getConvertedAmount(String from, String to, double amount){

    HomeScreenGateway.getConvertedData(from: from, to: to, amount: amount).then((value) {
      if(value.isSuccess==true){
        String toAmount = value.data!.rates.gBP.rateForAmount;
        _convertorListSink?.add(toAmount);
      }


    });


  }


}

abstract class PageState {}

class LoadingState extends PageState {}

class EmptyState extends PageState {}

class DataLoadedState extends PageState {
  final CurrencyList data;
  DataLoadedState(this.data);
}

class ConvertedState extends PageState {
  final ConvertorModel data;
  ConvertedState(this.data);
}