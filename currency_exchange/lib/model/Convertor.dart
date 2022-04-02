class ConvertorModel {
  late String baseCurrencyCode;
  late String baseCurrencyName;
  late String amount;
  late Rates  rates;
  late String status;

  ConvertorModel.empty(){
    baseCurrencyCode='';
    baseCurrencyName='';
    amount='0.0';

    rates=Rates.empty();
    status='';
  }

  ConvertorModel.fromJson(Map<String, dynamic> json,String to) {
    baseCurrencyCode = json['base_currency_code']??'';
    baseCurrencyName = json['base_currency_name']??'';
    amount = json['amount']??'0.0';
    rates = (json['rates'] != null?Rates.fromJson(json['rates'],to) : Rates.empty());
    status = json['status']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['base_currency_code'] = this.baseCurrencyCode;
    data['base_currency_name'] = this.baseCurrencyName;
    data['amount'] = this.amount;
    if (this.rates != null) {
      data['rates'] = this.rates.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Rates {
  late GBP gBP;

  Rates.empty(){
    gBP= GBP.empty();
  }

  Rates.fromJson(Map<String, dynamic> json,String to) {

    gBP = json[to] != null ?  GBP.fromJson(json[to]) : GBP.empty();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gBP != null) {
      data['GBP'] = this.gBP.toJson();
    }
    return data;
  }
}

class GBP {
 late String currencyName;
 late String rate;
 late String rateForAmount;

  GBP.empty(){
    currencyName='';
    rate='0.0';
    rateForAmount= '0.0';
  }

  GBP.fromJson(Map<String, dynamic> json) {
    currencyName = json['currency_name'];
    rate = json['rate']??'0.0';
    rateForAmount = json['rate_for_amount']??'0.0';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_name'] = this.currencyName;
    data['rate'] = this.rate;
    data['rate_for_amount'] = this.rateForAmount;
    return data;
  }
}
