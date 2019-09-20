import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_meter/model/meter.dart';
import 'package:your_meter/util/dbhelper.dart';
import 'package:intl/intl.dart';

class MeterPage extends StatefulWidget {
  final Meter meter;

  MeterPage({this.meter});

  @override
  _MeterPageState createState() => _MeterPageState();
}

class _MeterPageState extends State<MeterPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final helper = DatabaseHelper();

  final txtMeterCtrl = TextEditingController();
  final txtAmountCtrl = TextEditingController();
  bool hasTMD = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tr('newRecord')),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            _getBanner(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (t) {
                  return t.isEmpty
                      ? AppLocalizations.of(context).tr('require')
                      : null;
                },
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                controller: txtMeterCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).tr('label-1')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (t) {
                  return t.isEmpty
                      ? AppLocalizations.of(context).tr('require')
                      : null;
                },
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                controller: txtAmountCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).tr('label-2')),
              ),
            ),
            RaisedButton.icon(
              onPressed: !hasTMD ? _saveRecord : null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              textColor: Colors.white,
              color: Colors.blue,
              icon: Icon(Icons.save),
              label: Text(AppLocalizations.of(context).tr('saveRecord')),
            )
          ],
        ),
      ),
    );
  }

  void _saveRecord() {
    if (!formKey.currentState.validate()) return;

    Meter meter = new Meter(
        unit: int.parse(txtMeterCtrl.text),
        totalAmount: int.parse(txtAmountCtrl.text),
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()));

    if (widget.meter == null) {
      helper.insertMeter(meter);
      showSnackBar(AppLocalizations.of(context).tr('newRecordSaved'));

      txtAmountCtrl.clear();
      txtMeterCtrl.clear();

      check();
    }
  }

  Widget _getBanner() {
    return hasTMD
        ? Container(
            width: double.infinity,
            height: 40,
            color: Colors.red.withOpacity(0.9),
            child: Center(
                child: Text(
              AppLocalizations.of(context).tr('alreadyRecord'),
              style: TextStyle(fontSize: 16, color: Colors.white),
            )),
          )
        : Container();
  }

  void showSnackBar(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.blue.withOpacity(0.9),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future check() async {
    var today = DateTime.now();
    await helper
        .hasData(today.year.toString(), DateFormat('MM').format(today))
        .then((i) {
      setState(() {
        hasTMD = i;
      });
    });
  }
}
