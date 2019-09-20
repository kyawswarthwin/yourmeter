import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:your_meter/model/meter.dart';
import 'package:your_meter/screen/calculator.dart';
import 'package:your_meter/screen/meter.dart';
import 'package:your_meter/screen/meter_record.dart';
import 'package:your_meter/util/dbhelper.dart';
import 'package:your_meter/util/general.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final helper = DatabaseHelper();
  final recordLimit = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//
//    helper.deleteAllMeter();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 200,
          child: FutureBuilder(
            future: helper.getMeterList('ASC'),
            builder:
                (BuildContext context, AsyncSnapshot<List<Meter>> snapshot) {
              return snapshot.hasData
                  ? (snapshot.data.length > 0)
                      ? SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          title: ChartTitle(
                            text:
                                AppLocalizations.of(context).tr('meterRecord'),
                          ),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<Meter, String>>[
                              LineSeries<Meter, String>(
                                  dataSource: snapshot.data,
                                  xValueMapper: (Meter meter, _) {
                                    var date = DateTime.parse(meter.date);
                                    return DateFormat.yMMM().format(date);
                                  },
                                  yValueMapper: (Meter meter, _) => meter.unit,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true))
                            ])
                      : Center(
                          child:
                              Text(AppLocalizations.of(context).tr('noRecord')),
                        )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
              ;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: RaisedButton.icon(
            icon: Icon(Icons.add),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MeterPage()));
            },
            label: Text(
              AppLocalizations.of(context).tr('newRecord'),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: RaisedButton.icon(
            icon: Icon(Icons.confirmation_number),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Calculator()));
            },
            label: Text(
              AppLocalizations.of(context).tr('meterBillCal'),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).tr('title-1'),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MeterRecord()));
                },
              )
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 250,
            child: FutureBuilder(
              future: helper.getLastMeterList(recordLimit),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Meter>> snapshot) {
                return snapshot.hasData
                    ? (snapshot.data.length > 0)
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              var meter = snapshot.data[index];
                              var date = DateTime.parse(meter.date);

                              return ListTile(
                                dense: true,
                                title: Text(
                                    '${getMonthName(date.month)}, ${date.year}'),
                                trailing: Text(
                                    "${meter.unit} ${AppLocalizations.of(context).tr('unit')}"),
                                onTap: () {},
                              );
                            },
                          )
                        : Center(
                            child: Text(
                                AppLocalizations.of(context).tr('noRecord')),
                          )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            )),
        Container(
          padding: EdgeInsets.all(10),
          height: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Developed with',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45),
              ),
              FlutterLogo(
                size: 30,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
