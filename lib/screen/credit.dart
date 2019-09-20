
import 'package:flutter/material.dart';

class Credit extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text('Thanks List', style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
            Divider(),
            SizedBox(height: 10,),
            Flexible(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                 Card(
                   child: ListTile(
                     title: Text('sqflite'),
                     subtitle:  Text('https://pub.dev/packages/sqflite'),
                   ),
                 ),

                  Card(
                    child: ListTile(
                      title: Text('path_provider'),
                      subtitle:  Text('https://pub.dev/packages/path_provider'),
                    ),
                  ),


                  Card(
                    child: ListTile(
                      title: Text('flutter_launcher_icons'),
                      subtitle:  Text('https://pub.dev/packages/flutter_launcher_icons'),
                    ),
                  ),


                  Card(
                    child: ListTile(
                      title: Text('easy_localization'),
                      subtitle:  Text('https://pub.dev/packages/easy_localization'),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: Text('http'),
                      subtitle:  Text('https://pub.dev/packages/http'),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: Text('shared_preferences'),
                      subtitle:  Text('https://pub.dev/packages/shared_preferences'),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: Text('rxdart'),
                      subtitle:  Text('https://pub.dev/packages/rxdart'),
                    ),
                  ),


                  Card(
                    child: ListTile(
                      title: Text('url_launcher'),
                      subtitle:  Text('https://pub.dev/packages/url_launcher'),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: Text('syncfusion_flutter_charts'),
                      subtitle:  Text('https://pub.dev/packages/syncfusion_flutter_charts'),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: Text('Icons & Image'),
                      subtitle:  Text('Free icons from www.iconfinder.com'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
