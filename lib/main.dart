import 'dart:io';

import 'package:admin/components/progress_dialog.dart';
import 'package:admin/models/user.dart';
import 'package:admin/screens/about.dart';
import 'package:admin/screens/add.dart';
import 'package:admin/screens/add_new.dart';
import 'package:admin/screens/feedback.dart';
import 'package:admin/screens/home.dart';
import 'package:admin/screens/news.dart';
import 'package:admin/services/auth.dart';
import 'package:admin/wrapper.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
        home: WillPopScope(
          onWillPop: () {},
          child: Wrapper(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget setPages = Home();
  String title = "Admin";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.WARNING,
                  animType: AnimType.SCALE,
                  tittle: 'Warning',
                  desc: 'Are you sure want to exit?',
                  dismissOnTouchOutside: false,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    exit(0);
                   Navigator.pop(context, true);
                  }).show();
            },
          )
        ],
      ),
      body: setPages,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.restaurant,
                    size: 80,
                    color: Colors.white,
                  ),
                  Text('Cooking Guide',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              )),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.home),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Home")
                ],
              ),
              onTap: () {
                setState(() {
                  title = "Home";
                  setPages = Home();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.new_releases),
                  SizedBox(
                    width: 10,
                  ),
                  Text("News")
                ],
              ),
              onTap: () {
                setState(() {
                  title = "News";
                  setPages = News();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add_to_photos),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Add Food")
                ],
              ),
              onTap: () {
                setState(() {
                  title = "Add Food";
                  setPages = AddFood();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add_to_photos),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Add News")
                ],
              ),
              onTap: () {
                setState(() {
                  title = "Add News";
                  setPages = AddNew();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.report),
                  SizedBox(
                    width: 10,
                  ),
                  Text("About")
                ],
              ),
              onTap: () {
                setState(() {
                  title = "About";
                  setPages = About();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.feedback),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Feedback & Suggest")
                ],
              ),
              onTap: () {
                setState(() {
                  title = "Feedback & Suggest";
                  setPages = FeedBack();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.exit_to_app),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Sign Out")
                ],
              ),
              onTap: () {
                dialog(context).show();
                AuthService().signOut().then((onValue) {
                  dialog(context).hide();
                }, onError: (d) {
                  dialog(context).hide();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
