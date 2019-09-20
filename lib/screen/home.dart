import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:your_meter/screen/about.dart';
import 'package:your_meter/screen/calculator.dart';
import 'package:your_meter/screen/credit.dart';
import 'package:your_meter/screen/dashboard.dart';
import 'package:your_meter/screen/language.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).tr('app.title')),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Center(
                        child: Image.asset("assets/icon/icon.png"),
                      ),
                      decoration: BoxDecoration(color: Colors.black45),
                    ),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text(AppLocalizations.of(context).tr('home')),
                      onTap: () {
                        setState(() {
                          pageIndex = 0;
                        });
                        Navigator.pop(context);
                      },
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      leading: Icon(Icons.language),
                      title: Text(AppLocalizations.of(context).tr('language')),
                      onTap: () {
                        setState(() {
                          pageIndex = 2;
                        });
                        Navigator.pop(context);
                      },
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text(AppLocalizations.of(context).tr('about')),
                      onTap: () {
                        setState(() {
                          pageIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('Credits'),
                      onTap: () {
                        setState(() {
                          pageIndex = 4;
                        });
                        Navigator.pop(context);
                      },
                      trailing: Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
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
              )
            ],
          ),
        ),
        body: getPage());
  }

  getPage() {
    /// dashboard
    /// calculator
    /// language
    /// about
    /// credit

    switch (pageIndex) {
      case 0:
        return Dashboard();
      case 1:
        return Calculator();
      case 2:
        return Language();
      case 3:
        return About();
      case 4:
        return Credit();
    }
  }
}
