
class CurrencyList {
  late List<Currency> currencyList;

  CurrencyList.empty(){
    currencyList = [];
  }


  CurrencyList.fromJsonList(List<dynamic>? json) {
    currencyList = <Currency>[];
    if (json != null) {
      json.forEach((v) {
        currencyList.add(Currency.fromJson(v)) ;
      });
    }
  }
}



class Currency {
  late int id;
  late String currencyShort;
  late String currencyLong;

  Currency.empty(){
    id=0;
    currencyShort = '';
    currencyLong='';
  }

  Currency.fromJson(Map<String, dynamic> json) {
    id= json['id']??0;
    currencyShort = json['currency_short']??'';
    currencyLong = json['currency_long']??'';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['currency_short'] = this.currencyShort;
    data['currency_long'] = this.currencyLong;
    return data;
  }
}
