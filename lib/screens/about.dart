import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(title: Text("V-IT Project", style: TextStyle(fontWeight: FontWeight.bold),),),
          ListTile(title: Text("Chit Ye Aung"),),
          ListTile(title: Text("Kyaw Min Tun"),),
          ListTile(title: Text("Sithu Lwin"),),
        ],
      ),
    );
  }
}
