import 'dart:async';

import 'package:your_meter/model/result.dart';
import 'package:rxdart/rxdart.dart';

class MeterBloc {
  StreamController<bool> _checkCtrl = StreamController();

  Stream<bool> checkStream() => _checkCtrl.stream;

  void checkChanged(bool status) {
    _checkCtrl.sink.add(status);
  }

  PublishSubject<Result> _resultCtrl = PublishSubject<Result>();

  Stream<Result> resultStream() => _resultCtrl.stream;

  void calculate(bool industry, int unit) {
    var unitRages = !industry
        ? [0, 30, 50, 75, 100, 150, 200]
        : [0, 500, 5000, 10000, 20000, 50000, 100000];
    var units = !industry
        ? [30, 20, 25, 25, 50, 50]
        : [500, 4500, 5000, 10000, 30000, 50000];
    var prices = !industry
        ? [35, 50, 70, 90, 110, 120, 125]
        : [125, 135, 145, 155, 165, 175, 180];

    var usage = <int>[];

    for (int i = 0; i < 6; i++) {
      if (unit > unitRages[i] && unit <= unitRages[i + 1]) {
        usage.add(unit - unitRages[i]);
      } else if (unit > unitRages[i + 1]) {
        usage.add(units[i]);
      } else {
        break;
      }
    }

    if (unit > unitRages[6]) {
      usage.add(unit - unitRages[6]);
    }

    int totalAmount = 0;

    //print("Result::${industry ? "Industry" : "Normal"}");

    for (int i = 0; i < usage.length; i++) {
      totalAmount += usage[i] * prices[i];

      //print("${usage[i]}\t=\t${usage[i] * prices[i]}");
    }
    //print("Total Amount: $totalAmount");

    _resultCtrl.sink.add(Result(usage: usage, totalAmount: totalAmount));
  }

  void dispose() {
    _resultCtrl.close();
    _checkCtrl.close();
  }
}
