abstract class Abstract {
  String id;
  Map<String, dynamic> toMap();
}

class Model1 implements Abstract {
  String name = "A";
  int age = 23;

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['age'] = age;
    return map;
  }

  @override
  String id;
}

class Model2 implements Abstract {
  String name = "B";
  int age = 22;
  String address = "Yangon";

  @override
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['age'] = age;
    map['address'] = address;
    return map;
  }

  @override
  String id;
}

void printAll(Abstract abstract) {
  Map<String, dynamic> map = abstract.toMap();

  map.forEach((key, value) {
    print("$key : $value");
  });
}

void main() {
  printAll(Model1());
  print('');
  printAll(Model2());
}
