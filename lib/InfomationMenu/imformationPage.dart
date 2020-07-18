import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:promotion_mrt/HomePage/Object/informaiontObject.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:promotion_mrt/HomePage/Promotion/PromotionPage.dart';
import 'package:promotion_mrt/InfomationMenu/subInformation/ticketPrice.dart';
import 'package:promotion_mrt/OtherMenu/OtherPage.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class InfomationPage extends StatefulWidget {
  @override
  _InfomationPageState createState() => _InfomationPageState();
}

class _InfomationPageState extends State<InfomationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('BANGKOK MRT')),
        ),
        body: _informationMenu());
  }

  var parking;
  var tickets;
  var webView;

  Widget _onTaped(int index, String url, String title) {
    print("Yoh Yoh $index");

    switch (index) {
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebviewScaffold(
                  url: url,
                  appBar: AppBar(
                    title: Text(title),
                  ))),
        );
        break;
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebviewScaffold(
                    url: url,
                    appBar: AppBar(
                      title: Text(title),
                    ),
                  )),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebviewScaffold(
                  url: url,
                  appBar: AppBar(
                    title: Text(title),
                  ))),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebviewScaffold(
                  url: url,
                  appBar: AppBar(
                    title: Text(title),
                  ))),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebviewScaffold(
                  url: url,
                  appBar: AppBar(
                    title: Text(title),
                  ))),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebviewScaffold(
                  url: url,
                  appBar: AppBar(
                    title: Text(title),
                  ))),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebviewScaffold(
                  url: url,
                  appBar: AppBar(
                    title: Text(title),
                  ))),
        );
        break;
      default:
        return null;
    }
  }

  Widget _informationMenu() {
    return FutureBuilder(
        future: _fetchInformationList(),
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
            parking = _allInfo[0].urlWebview;

            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) => new Container(
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new NetworkImage("${_allInfo[index].bgCover}"),
                        fit: BoxFit.cover)),
                child: GestureDetector(
                  onTap: () => _onTaped(index, _allInfo[index].urlWebview, _allInfo[index].title),
                ),
              ),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 1.2 : 1.2),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<InfomationObject> _fetchInformationList() async {
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
