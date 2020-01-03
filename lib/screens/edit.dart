import 'package:admin/components/progress_dialog.dart';
import 'package:admin/models/menu_item.dart';
import 'package:admin/models/posts.dart';
import 'package:admin/services/data.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class EditFood extends StatefulWidget {
  final Post post;
  EditFood(this.post);

  @override
  _EditFoodState createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  FoodMenu foodMenuInfo;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post.title;
    _bodyController.text = widget.post.body;
    foodMenu.forEach((f) {
      if (f.foodType.toString() == widget.post.type.toString()) {
        setState(() {
          foodMenuInfo = f;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Edit Post"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            Material(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  widget.post.url,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
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
              controller: _bodyController,
              maxLines: 10,
              decoration: InputDecoration(
                  labelText: "Post Body",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Colors.green,
                child: Text("Update"),
                onPressed: () async {
                  if (!isValided()) {
                    return;
                  }
                  dialog(context).show();
                  //print("${_titleController.text} \n${_bodyController.text} \n${widget.post.url}\n ${foodMenuInfo.foodType.toString()} ");
                  int updated = await DataRepo().updatePost(Post(
                      id: widget.post.id,
                      title: _titleController.text,
                      body: _bodyController.text,
                      url: widget.post.url,
                      type: foodMenuInfo.foodType.toString()));
                  dialog(context).hide();
                  if (updated == 1) {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.SCALE,
                        tittle: 'Success',
                        desc: 'Your data is updated!',
                        dismissOnTouchOutside: false,
                        btnOkOnPress: () {
                          Navigator.pop(context);
                        }).show();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isValided() {
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
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ));
  }
}
