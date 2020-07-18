import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:promotion_mrt/HomePage/Object/MetroMallObject.dart';

class ShowPopUp extends StatefulWidget {
  @override
  _ShowPopUpState createState() => _ShowPopUpState();
}

class _ShowPopUpState extends State<ShowPopUp> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Show pop up"),
    );
  }
  Future<MetroMallObject> _fetchMainPageList() async {
    // print('_fetchMainPageList');
    try {
      String homePageUrl =
          "http://bem-v2.podrealm.com/webservice/api/Station/getMetroMall";
      Response response = await Dio().get(homePageUrl);
      var resultOfList = MetroMallObject.fromJson(response.data);
      //print(response.data);
      //print("ResultOfList: $resultOfList");
      if (resultOfList.errCode == 0) {
        return resultOfList;
      } else {
        _showDialog(resultOfList.errMessage);
        return null;
      }
    } on DioError catch (e) {
      //print('ERROR Message >>> ${e.message}');
      _showDialog(e.message);
      return null;
    }
  }

  void _showDialog(String errMessage) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}