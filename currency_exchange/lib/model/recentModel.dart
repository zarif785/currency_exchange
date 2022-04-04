class RecentList {
  late List<RecentsModel> recents;

  RecentList.empty(){
    recents = [];
  }


  RecentList.fromJsonList(List<dynamic>? json) {
    recents = <RecentsModel>[];
    if (json != null) {
      json.forEach((v) {
        recents.add(RecentsModel.fromJson(v)) ;
      });
    }
  }

}


class RecentsModel {
  late int id;
  late int fromId;
  late int toId;
  late double amountFrom;
  late double amountTo;
  late String currencyFrom;
  late String currencyTo;

  RecentsModel.empty(){
    id=0;
    fromId=0;
    toId=0;
    amountFrom=0.0;
    amountTo=0.0;
    currencyFrom='';
    currencyTo='';
  }


  RecentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    fromId = json['from_id']??0;
    toId = json['to_id']??0;
    amountFrom = json['amount_from'].toDouble()??0.0;
    amountTo = json['amount_to'].toDouble()??0.0;
    currencyFrom = json['currency_from']??'';
    currencyTo = json['currency_to']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_id'] = this.fromId;
    data['to_id'] = this.toId;
    data['amount_from'] = this.amountFrom;
    data['amount_to'] = this.amountTo;
    data['currency_from'] = this.currencyFrom;
    data['currency_to'] = this.currencyTo;
    return data;
  }
}
