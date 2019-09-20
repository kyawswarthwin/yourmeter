import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  TextStyle style = TextStyle(fontStyle: FontStyle.italic, color: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icon/icon.png",
              height: 150,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Your Meter',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Electronic Meter Bill Calculator & Tracker'),
            SizedBox(
              height: 30,
            ),
            Text('Version: 1.0'),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Source Code: '),
                link(
                  url: '',
                  text: 'github.com/yourmeter'
                ),

              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text('Developer: Kyaw Nyein Phyo (Michael)'),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('E-mail: '),
                link(
                  url: 'mailto:<kyawgyi16.knp@gmail.com>',
                  text: 'kyawgyi16.knp@gmail.com',
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Facebook: '),
                link(
                  url: 'https://www.facebook.com/cyberXnoob',
                  text: 'facebook.com/cyberXnoob',
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('GitHub: '),
                link(
                    url: 'https://github.com/cyber-noob',
                    text: 'github.com/cyber-noob'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
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
            )
          ],
        ),
      ),
    );
  }

  Widget link({url, text}) {
    return GestureDetector(
      onTap: () {
        launchURL(url);
      },
      child: Text(
        text,
        style: style,
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
