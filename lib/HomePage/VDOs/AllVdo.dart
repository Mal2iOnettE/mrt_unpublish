import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:promotion_mrt/HomePage/Object/MainPageObject.dart';
import 'package:promotion_mrt/HomePage/Object/VdoObject.dart';

class AllVdo extends StatefulWidget {
  @override
  _AllVdoState createState() => _AllVdoState();
}

class _AllVdoState extends State<AllVdo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All Vdo'),
        ),
        body: _buildMainPageWidget());
  }

  Widget _buildMainPageWidget() {
    return FutureBuilder(
        future: _fetchMainPageList(),
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
            AllVdoObject allVdoObject = snapShot.data;
            var _allVdo = allVdoObject.vdolist;
            return Container(
              height: 600,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 800.0, // image height
                      child: ListView.builder(
                        itemExtent: 315, //image width
                        itemCount: allVdoObject.vdolist.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => Container(
                            height: 150.0,
                            margin: EdgeInsets.all(5.0),
                            child: Card(
                              child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 242.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              _allVdo[index].vdoCover),
                                          fit: BoxFit.cover)),
                                  child: GestureDetector(
                                    onTap: () {
                                      FlutterYoutube.playYoutubeVideoByUrl(
                                        apiKey:
                                            "AIzaSyCit4DO9_PvqhgtNP4p1k7k55o9Xla7_0E",
                                        videoUrl:
                                            "https://www.youtube.com/watch?v=" +
                                                _allVdo[index].vdoUrl,
                                        autoPlay: true,
                                        fullScreen: false,
                                      );
                                    },
                                    child: Image.asset(
                                        "images/icons/youtube/img_icon_youtube.png"),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 5.0,
                                      right: 5.0,
                                      top: 250.0,
                                      bottom: 10.0),
                                  height: 250.0,
                                  child: Text(
                                    "${_allVdo[index].vdoTitle}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ))),
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

  Future<AllVdoObject> _fetchMainPageList() async {
    //print('_fetchMainPageList');
    try {
      String homePageUrl =
          "http://bem-v2.podrealm.com/webservice/api/Vdo/getVdo";
      Response response = await Dio().get(homePageUrl);
      var resultOfList = AllVdoObject.fromJson(response.data);
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
