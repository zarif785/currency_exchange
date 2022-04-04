
import 'dart:async';

import 'package:currency_exchange/common/utils/validator.dart';
import 'package:currency_exchange/model/Convertor.dart';
import 'package:currency_exchange/model/Currency.dart';
import 'package:currency_exchange/module/home_screen/gateway/home_screen_gateway.dart';
import 'package:currency_exchange/module/recent_screen/service/recent_screen_service.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/utils/Toasty.dart';


abstract class _ViewModel{

  void navigateToRecentScreen();
  void navigateToFavoriteScreen();
}


mixin HomeScreenService<T extends StatefulWidget>on State<T>implements _ViewModel{
  late _ViewModel _view;

  @override
  void initState() {
    _view = this;
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

   void getConvertedAmount(String from, String to,String amount,int fromId,int toId){
     double? amountFrom;
    if(Validator.isValidNumber(amount)){
      amountFrom = double.tryParse(amount);
    }
    else{
      Toasty.of(context).showError(message: "Not a Valid Number");
    }


    HomeScreenGateway.getConvertedData(from: from, to: to, amount: amountFrom!).then((value) {
      if(value.isSuccess==true){
        String toAmount = value.data!.rates.gBP.rateForAmount;
        _convertorListSink?.add(toAmount);
        setConvertedData(from, to, amountFrom!, double.parse(toAmount),fromId,toId);

      }
      else{
        Toasty.of(context).showError(message: "Could not find currency.Try Again");
      }


    });


  }

  void setConvertedData(String currency_from,String currency_to, double amount_from,double amount_to,int fromID, int toId){


    HomeScreenGateway.setConvertedData(currency_from, currency_to, amount_from,amount_to,fromID,toId).then((value){

      if(value.isSuccess==true){

      }
      else{
        print(value.message);
        Toasty.of(context).showError(message:value.message);
      }

    });

  }


  void recentPageNavigate(){
    _view.navigateToRecentScreen();

  }

  void favoritePageNavigate(){
    _view.navigateToFavoriteScreen();

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