class Popular {
  late String currencyFrom;
  late String currencyTo;

  Popular.empty(){
    currencyFrom='';
    currencyTo='';
  }

  Popular.fromJson(Map<String, dynamic> json) {
    currencyFrom = json['currency_from']??'';
    currencyTo = json['currency_to']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_from'] = this.currencyFrom;
    data['currency_to'] = this.currencyTo;
    return data;
  }
}

class PopularList {
  late List<Popular> popular;

  PopularList.empty(){
    popular = [];
  }


  PopularList.fromJsonList(List<dynamic>? json) {
    popular = <Popular>[];
    if (json != null) {
      json.forEach((v) {
        popular.add(Popular.fromJson(v)) ;
      });
    }
  }

}
