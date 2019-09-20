import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:your_meter/model/result.dart';
import 'package:your_meter/bloc/meter_%20bloc.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<String> columnNames;

  var txtUnitCtrl = TextEditingController();
  bool industry = false;

  var meterBloc = MeterBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    meterBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    columnNames = [
      AppLocalizations.of(context).tr('range'),
      AppLocalizations.of(context).tr('price'),
      AppLocalizations.of(context).tr('unit'),
      AppLocalizations.of(context).tr('amount')
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).tr('meterBillCal')),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Text(AppLocalizations.of(context).tr('industry')),
                    StreamBuilder<bool>(
                        stream: meterBloc.checkStream(),
                        builder: (context, snapshot) {
                          return Checkbox(
                              value: snapshot.hasData ? snapshot.data : false,
                              onChanged: (e) {
                                meterBloc.checkChanged(e);
                                industry = e;
                              });
                        }),
                    Expanded(
                      child: TextField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        controller: txtUnitCtrl,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).tr('label-1'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    int meter = (txtUnitCtrl.text.isEmpty)
                        ? 0
                        : int.parse(txtUnitCtrl.text);
                    meterBloc.calculate(industry, meter);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(AppLocalizations.of(context).tr('calculate')),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: StreamBuilder<Result>(
                    stream: meterBloc.resultStream(),
                    builder: (context, snapshot) {
                      return DataTable(
                          columns: columnNames.map((e) {
                            return DataColumn(
                                numeric: true,
                                label: Text(
                                  e,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ));
                          }).toList(),
                          rows: dataRowGenerate(snapshot.data));
                    }),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).tr('label-2'),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        StreamBuilder<Result>(
                            stream: meterBloc.resultStream(),
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? Text(
                                      '${snapshot.data.totalAmount} ${AppLocalizations.of(context).tr('ks')}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      '0 ${AppLocalizations.of(context).tr('ks')}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    );
                            }),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  dataRowGenerate(Result result) {
    var unitRages = !industry
        ? [0, 30, 50, 75, 100, 150, 200]
        : [0, 500, 5000, 10000, 20000, 50000, 100000];

    var prices = !industry
        ? [35, 50, 70, 90, 110, 120, 125]
        : [125, 135, 145, 155, 165, 175, 180];

    var rows = <DataRow>[];

    if (result == null) {
      for (int i = 0; i < 6; i++) {
        int unit = 0;
        int amount = 0;

        rows.add(DataRow(cells: [
          DataCell(Text(
              "${unitRages[i] + 1} ${AppLocalizations.of(context).tr('to')} ${unitRages[i + 1]}")),
          DataCell(
              Text("${prices[i]} ${AppLocalizations.of(context).tr('ks')}")),
          DataCell(
            Text('$unit'),
          ),
          DataCell(Text("$amount ${AppLocalizations.of(context).tr('ks')}"))
        ]));
      }
    } else {
      print(result.usage);
      print(result.totalAmount);
      for (int i = 0; i < 6; i++) {
        int unit = (i > result.usage.length - 1) ? 0 : result.usage[i];
        int amount = (i > result.usage.length - 1) ? 0 : unit * prices[i];

        rows.add(DataRow(cells: [
          DataCell(Text(
              "${unitRages[i] + 1} ${AppLocalizations.of(context).tr('to')} ${unitRages[i + 1]}")),
          DataCell(
              Text("${prices[i]} ${AppLocalizations.of(context).tr('ks')}")),
          DataCell(
            Text('$unit'),
          ),
          DataCell(Text("$amount ${AppLocalizations.of(context).tr('ks')}"))
        ]));
      }
    }

    return rows;
  }
}
