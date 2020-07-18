import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:promotion_mrt/HomePage/Object/informaiontObject.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends State<WebView> {
  String ticketsUrl = "";
var webViewUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tickets Prices"),
      ),
      body: _ticketsPrices(),
    );
  }

  Widget _ticketsPrices() {
    return FutureBuilder(
        future: _ticketsPriceList(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.none &&
              snapShot.hasData == null) {
            return Container(
              child: Text(
                'Your promotion is empty.',
                style: TextStyle(
                    color: Color.fromRGBO(233, 233, 232, 1),
                    fontWeight: FontWeight.w200,
                    fontFamily: 'prompt',
                    fontSize: 22),
              ),
            );
          } else if (snapShot.hasData) {
            InfomationObject informationObject = snapShot.data;

            var _allInfo = informationObject.menulist;
            return ListView.builder(
              itemCount: informationObject.menulist.length,
              itemBuilder: (context, index) {
                webViewUrl = _allInfo[index].urlWebview;
                print(webViewUrl);
              return Container(
                height: 900,
                child: WebviewScaffold(
                  url: webViewUrl,
                ),
              );
              
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<InfomationObject> _ticketsPriceList() async {
    //print('_fetchMainPageList');
    try {
      String homePageUrl =
          "http://bem-v2.podrealm.com/webservice/api/Main/getInformationpage";
      Response response = await Dio().get(homePageUrl);
      var resultOfList = InfomationObject.fromJson(response.data);
      //print(response.data);
      //print("ResultOfList: $resultOfList");
      if (resultOfList.errCode == 0) {
        return resultOfList;
      } else {
        _showDialog(resultOfList.errMessage);
        return null;
      }
    } on DioError catch (e) {
      print('ERROR Message >>> ${e.message}');
      _showDialog(e.message);
      return null;
    }
  }

  void _showDialog(String message) {
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
