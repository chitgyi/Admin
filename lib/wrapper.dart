import 'package:admin/main.dart';
import 'package:admin/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Login();
    } else {
      return MyHomePage();
    }
  }
}
