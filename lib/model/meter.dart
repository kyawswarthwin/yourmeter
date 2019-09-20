class Meter {
  int id;
  int unit;
  int totalAmount;
  String date;

  Meter({this.id, this.unit, this.totalAmount, this.date});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['unit'] = unit;
    map['totalAmount'] = totalAmount;
    map['date'] = date;
    return map;
  }
}
