class Popular {
  late String currencyFrom;
  late String currencyTo;
  late int count;

  Popular.empty(){
    currencyFrom='';
    currencyTo='';
    count = 0;
  }

  Popular.fromJson(Map<String, dynamic> json) {
    currencyFrom = json['currency_from']??'';
    currencyTo = json['currency_to']??'';
    count = json['COUNT(recents.from_id)']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['currency_from'] = currencyFrom;
    data['currency_to'] = currencyTo;
    data['COUNT(recents.from_id)'] = count;


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
