import 'package:admin/components/progress_dialog.dart';
import 'package:admin/models/user.dart';
import 'package:admin/screens/add.dart';
import 'package:admin/screens/home.dart';
import 'package:admin/services/auth.dart';
import 'package:admin/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
     return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
        home: Wrapper(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget setPages = Home();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),actions: <Widget>[
        IconButton(icon: Icon(Icons.exit_to_app),onPressed: ()async{
          dialog(context).show();
          await AuthService().signOut();
          dialog(context).hide();
        },)
      ],),
      body: setPages,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
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
                  setPages = Home();
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
                  setPages = AddFood();
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
                  Text("Reported Posts")
                ],
              ),
              onTap: () {
                setState(() {
                  setPages = AddFood();
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
                  setPages = AddFood();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
        
      ),
    );
  }
}
