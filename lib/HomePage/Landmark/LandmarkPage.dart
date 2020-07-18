import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:promotion_mrt/HomePage/HomePageAPI.dart';
import 'package:promotion_mrt/HomePage/Landmark/LandMarkDetail.dart';
import 'package:promotion_mrt/HomePage/Object/MainPageObject.dart';
import 'package:promotion_mrt/HomePage/Promotion/PromotionPage.dart';
import 'package:promotion_mrt/OtherMenu/OtherPage.dart';

class LandMarkPage extends StatefulWidget {
  final int landID;
  final String landtitle;

  LandMarkPage({Key key, this.landtitle, this.landID}) : super(key: key);

  @override
  _LandMarkPageState createState() => _LandMarkPageState();
}

class _LandMarkPageState extends State<LandMarkPage> {
  @override
  Widget build(BuildContext context) {
    return _buildMainPageWidget();
  }

   _promotionpage(String landmarktitle, int landmarkId) {
    //print("thisi is $landmarktitle ,  land id : $landmarkId");
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              LandMarkDetail(title: landmarktitle,landId: landmarkId),
        ),
    );
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
            MainPageObject homePageObject = snapShot.data;
            // print("snapshot: ${snapShot.data}");
            var _landmark = homePageObject.landmarklist;
            // print("snapShot.data: ${snapShot.data}");
            return Container(
              height: 270,
              child: CustomScrollView(
                physics: NeverScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 270.0, // image height
                      child: ListView.builder(
                        itemExtent: 350, //image width
                        itemCount: homePageObject.landmarklist.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          height: 200.0,
                          margin: EdgeInsets.all(5.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: 220.0,
                                    //margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          new BoxShadow(
                                              color: Colors.black26,
                                              offset: new Offset(5.0, 5.0),
                                              blurRadius: 1.0)
                                        ],
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                _landmark[index].landmarkCover),
                                            fit: BoxFit.cover)),
                                    child: GestureDetector(
                                      onTap: () {
                                        _promotionpage(
                                            _landmark[index].landmarkName,
                                            _landmark[index].landId
                                        );
                                        //print( "${_landmark[index].landmarkName},${_landmark[index].landId}");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.all(6.0),
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          _landmark[index].landmarkName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
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
    //print('_fetchMainPageList');
    try {
      String homePageUrl =
          "http://bem-v2.podrealm.com/webservice/api/Main/getHomepage/";
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
