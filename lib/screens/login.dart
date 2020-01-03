import 'package:admin/components/progress_dialog.dart';
import 'package:admin/services/auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Login extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProgressDialog loading = dialog(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.teal[100],
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 120,
                  height: 120,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Center(
                child: Text("Cooking Guide Admin",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
            SizedBox(
              height: 60,
            ),
            Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail,
                  ),
                  labelText: "E-mail",
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: _passController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                ),
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
              obscureText: true,
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(top: 10),
              child: RaisedButton(
                color: Colors.teal,
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (!_isValided()) return;
                  loading.show();
                  var user = await AuthService().signInWithEmail(
                      email: _emailController.text,
                      password: _passController.text);
                  loading.hide();

                  if (user == null) {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.SCALE,
                            tittle: 'Error',
                            desc:
                                'Your e-mail address or password is incorrected!',
                            dismissOnTouchOutside: false,
                            btnOkOnPress: () {})
                        .show();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _isValided() {
    if (_emailController.text.length < 1) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("E-mail filed is required!"),
      ));
      return false;
    }
    if (_passController.text.length < 1) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Password filed is required!"),
      ));
      return false;
    }
    return true;
  }
}
