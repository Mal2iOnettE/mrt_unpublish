import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:promotion_mrt/HomePage/ExMenu/Exmenu.dart';
import 'package:promotion_mrt/HomePage/Promotion/DealoftheDay.dart';
import 'package:promotion_mrt/HomePage/VDOs/AllVdo.dart';
import 'package:promotion_mrt/HomePage/subMenu/subMenu.dart';
import 'package:promotion_mrt/HomePage/Landmark/LandmarkPage.dart';
import 'package:promotion_mrt/HomePage/Object/MainPageObject.dart';
import 'package:promotion_mrt/HomePage/VDOs/VdoPage.dart';
import 'package:promotion_mrt/HomePage/News/News.dart';
import 'package:promotion_mrt/PromotionMenu/AllPromotionPage.dart';

class HomePage extends StatefulWidget {
  var vdoList;

  HomePage({Key key, this.vdoList}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

var colorMenu;
var adsCover;
var news;
var vdosCover;
var landMarkList;
var vdoList;
Response response;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //extendBodyBehindAppBar: true,
        //backgroundColor: Colors.blue[100],
        appBar:
            AppBar(elevation: 0.0, title: Center(child: Text("BANGKOK MRT"))),
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
            MainPageObject homePageObject = snapShot.data;
            var _adslist = homePageObject.adslist;
            colorMenu = homePageObject.colorMenu;

            adsCover = _adslist[0].adsCover;
            return Container(
                //height: 150,
                child: ListView(children: <Widget>[
              Stack(children: <Widget>[
                // Background with gradient
                Container(
                  height: 242,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(colorMenu), fit: BoxFit.cover)),
                ),
                /* Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBar(
                    // Add AppBar here only
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Center(
                        child: Text(
                      "BANGKOK MRT",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),*/
              ///Main cover
                Container(
                  margin: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 100.0, bottom: 10.0),
                  height: 250.0,
                  child: scrollImage(),
                ),
              ]),
            ////here subMenu
              Container(
                  margin: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 0.0, bottom: 5.0),
                  child: SubMenu()
              ),
            ///ExMenu
              Container(
                height: 250.0,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 5.0, color: Colors.black12))),
                child: Column(
                  children: <Widget>[
                    ExMenu()
                  ],
                ),
              ),
              
            ///News Menu
              Container(
                height: 340.0,
                padding: EdgeInsets.only(top: 5.0),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 5.0, color: Colors.black12))),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("News ToDay",style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    NewsPage()
                  ],
                ),
              ),
              /// Deal of The Day
              Container(
                height: 340.0,
                padding: EdgeInsets.only(top: 5.0),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 5.0, color: Colors.black12))),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Deal Of the day",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => AllPromotonPage()));
                      },
                    ),
                    DealOfTheDay()
                  ],
                ),
              ),
              //Landmark page
              Container(
                height: 340.0,
                padding: EdgeInsets.only(top: 5.0),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 5.0, color: Colors.black12))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "MRT Go Around",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      leading: Image.asset(
                          'images/icons/GoAround/img_icon_around.png'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => AllVdo()));
                      },
                    ),
                    LandMarkPage()
                  ],
                ),
              ),

              /// VDO PAGE
              Container(
                height: 340.0,
                padding: EdgeInsets.only(top: 5.0),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 5.0, color: Colors.black12))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "MRT Channel",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      leading: Image.asset(
                          'images/icons/img_icon_youtube_mrt_channel.png'
                        ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => AllVdo()));
                      },
                    ),
                    VdoPage()
                  ],
                ),
              ),
            ]));
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
          "http://bem-v2.podrealm.com/webservice/api/Main/getHomepage";
      response = await Dio().get(homePageUrl);
      var resultOfList = MainPageObject.fromJson(response.data);
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

/// AdsCover
Widget scrollImage() {
  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: SizedBox(
          height: 250.0, // image height
          child: ListView.builder(
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(), // unscrollable
            itemExtent: 400, //image width
            scrollDirection: Axis.horizontal,
            semanticChildCount: 1,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.all(0.0),
              //color: Colors.orangeAccent,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(adsCover))),
            ),
          ),
        ),
      ),
    ],
  );
}
