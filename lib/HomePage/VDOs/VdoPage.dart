import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:promotion_mrt/HomePage/HomePageAPI.dart';
import 'package:promotion_mrt/HomePage/Object/MainPageObject.dart';

class VdoPage extends StatefulWidget {
  @override
  _VdoPageState createState() => _VdoPageState();
}

class _VdoPageState extends State<VdoPage> {
  @override
  Widget build(BuildContext context) {
    return _buildMainPageWidget();
  }

  Widget _buildMainPageWidget() {
    return FutureBuilder(
        future: _fetchMainPageList(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.none &&
              snapShot.hasData == null) {
            return Container(
              child: Text(
                'Your data is empty.',
                style: TextStyle(
                    color: Color.fromRGBO(233, 233, 232, 1),
                    fontWeight: FontWeight.w200,
                    fontFamily: 'prompt',
                    fontSize: 22),
              ),
            );
          } else if (snapShot.hasData) {
            MainPageObject homePageObject = snapShot.data;
            var _vdolist = homePageObject.vdolist;
            return Container(
              height: 270,
              child: CustomScrollView(
                physics: NeverScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 260.0, // image height
                      child: ListView.builder(
                        //physics: AlwaysScrollableScrollPhysics(),
                        itemExtent: 350.0, //image width
                        itemCount: homePageObject.vdolist.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          //color: Colors.blue,
                          height: 600.0,
                          margin: EdgeInsets.all(5.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: 215.0,
                                    width: 800.0,
                                    //margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.black26,
                                            offset: new Offset(5.0, 5.0),
                                            blurRadius: 1.0
                                          )
                                        ],
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                _vdolist[index].vdoCover),
                                            fit: BoxFit.cover)),
                                    child: GestureDetector(
                                      onTap: () {
                                        FlutterYoutube.playYoutubeVideoByUrl(
                                          apiKey:
                                              "AIzaSyCit4DO9_PvqhgtNP4p1k7k55o9Xla7_0E",
                                          videoUrl:
                                              "https://www.youtube.com/watch?v=" +
                                                  _vdolist[index].vdoUrl,
                                          autoPlay: true,
                                          fullScreen: false,
                                        );
                                      },
                                      child: Image.asset(
                                          "images/icons/youtube/img_icon_youtube.png"),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 2.0, right: 8.0, bottom: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _vdolist[index].vdoTitle,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<MainPageObject> _fetchMainPageList() async {
    // print('_fetchMainPageList');
    try {
      String homePageUrl =
          "http://bem-v2.podrealm.com/webservice/api/Main/getHomepage";
      Response response = await Dio().get(homePageUrl);
      var resultOfList = MainPageObject.fromJson(response.data);
      // print(response.data);
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
