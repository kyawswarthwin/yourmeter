import 'package:flutter/material.dart';
import 'package:your_meter/screen/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  runApp(EasyLocalization(child: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          //app-specific localization
          EasylocaLizationDelegate(
            locale: data.locale,
            path: 'assets/langs',
          ),
        ],
        locale: data.savedLocale,
      ),
    );
  }
}
