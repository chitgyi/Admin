import 'dart:io';
import 'package:admin/main.dart';
import 'package:admin/models/menu_item.dart';
import 'package:admin/services/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddFood extends StatefulWidget {
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  File _image;
  final DataRepo dataRepo = DataRepo();
  // bool loading = false;
  FoodMenu foodMenuInfo;
  ProgressDialog pr;

  Future getImage() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(this.context, type: ProgressDialogType.Normal);
    pr.style(message: "Loading...");
    //Optional
    pr.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Material(
              child: InkWell(
                onTap: getImage,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(0.4))),
                      child: _image == null
                          ? Center(
                              child: Text("Select Image"),
                            )
                          : Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ),
                    )),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                  labelText: "Title"),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  border: Border.all(
                      width: 1, color: Colors.black.withOpacity(0.4))),
              child: DropdownButton<FoodMenu>(
                hint: Text(foodMenuInfo == null
                    ? "Select Food Type"
                    : foodMenuInfo.title),
                isExpanded: true,
                underline: Container(),
                items: foodMenu.map((FoodMenu food) {
                  return DropdownMenuItem<FoodMenu>(
                    value: food,
                    child: Text(food.title),
                  );
                }).toList(),
                onChanged: (_) {
                  setState(() {
                    foodMenuInfo = _;
                  });
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            TextField(
              maxLines: 10,
              controller: _bodyController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Post Body'),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(13),
                color: Colors.teal,
                child: Text(
                  "Create Meal",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (!_checkData()) {
                    return;
                  }
                  pr.show();
                  // setState(() {
                  //   loading = true;
                  // });

                  String url = await dataRepo.uploadImage(_image);
                  DocumentReference ref = await dataRepo.createPost(
                      foodType: foodMenuInfo.foodType,
                      title: _titleController.text,
                      body: _bodyController.text,
                      url: url);
                  pr.hide();
                  if (ref.documentID != null) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (cxt) => MyHomePage()));
                  }

                  // setState(() {
                  //   loading = false;
                  // });
                },
              ),
            )
          ],
        )));
  }

  bool _checkData() {
    if (_image.path == null) {
      _showSnack("Please select photo!");
      return false;
    }
    if (_titleController.text.length < 10) {
      _showSnack("Need more characters in title field!");
      return false;
    }
    if (foodMenuInfo == null) {
      _showSnack("Please select food type!");
      return false;
    }
    if (_bodyController.text.length < 30) {
      _showSnack("Need more characters in body field!");
      return false;
    }
    return true;
  }

  void _showSnack(String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ));
  }
}
