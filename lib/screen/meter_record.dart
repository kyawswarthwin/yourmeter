import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:your_meter/model/meter.dart';
import 'package:your_meter/util/dbhelper.dart';
import 'package:your_meter/util/general.dart';

class MeterRecord extends StatefulWidget {
  @override
  _MeterRecordState createState() => _MeterRecordState();
}

class _MeterRecordState extends State<MeterRecord> {
  static final columnsStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  List<DataColumn> columns;
  final helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    columns = [
      DataColumn(
        label: Text(
          AppLocalizations.of(context).tr('no'),
          textAlign: TextAlign.center,
          style: columnsStyle,
        ),
      ),
      DataColumn(
          label: Text(
        AppLocalizations.of(context).tr('date'),
        textAlign: TextAlign.center,
        style: columnsStyle,
      )),
      DataColumn(
        label: Text(
          AppLocalizations.of(context).tr('unit'),
          textAlign: TextAlign.center,
          style: columnsStyle,
        ),
      ),
      DataColumn(
          label: Text(
            AppLocalizations.of(context).tr('amount'),
            style: columnsStyle,
          ),
          numeric: true),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tr('meterRecord')),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: helper.getMeterList('DESC'),
            builder:
                (BuildContext context, AsyncSnapshot<List<Meter>> snapshot) {
              return snapshot.hasData
                  ? snapshot.data.length > 0
                      ? DataTable(
                          columns: columns,
                          rows: getRows(snapshot.data),
                        )
                      : nowRecord()
                  : loading();
            },
          ),
        ),
      ),
    );
  }

  Widget loading() {
    var screen = MediaQuery.of(context).size;

    return Container(
      height: screen.height - 100,
      width: screen.width,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget nowRecord() {
    var screen = MediaQuery.of(context).size;

    return Container(
      height: screen.height - 100,
      width: screen.width,
      child: Center(
        child: Text(AppLocalizations.of(context).tr('noRecord')),
      ),
    );
  }

  List<DataRow> getRows(var meterData) {
    var rows = <DataRow>[];

    int index = 0;

    for (var meter in meterData) {
      var date = DateTime.parse(meter.date);
      rows.add(DataRow(cells: [
        DataCell(
          Text(
            '${++index}',
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(Text('${getMonthName(date.month)}, ${date.year}')),
        DataCell(Text('${meter.unit}')),
        DataCell(Text(
            '${meter.totalAmount} ${AppLocalizations.of(context).tr('ks')}')),
      ]));
    }

    return rows;
  }
}
