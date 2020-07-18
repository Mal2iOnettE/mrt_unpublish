import 'package:dio/dio.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:promotion_mrt/HomePage/ExMenu/StationAndMetromall/showPopup.dart';
import 'package:promotion_mrt/HomePage/Object/MetroMallObject.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class MetroMall extends StatefulWidget {
  @override
  _MetroMallState createState() => _MetroMallState();
}

class _MetroMallState extends State<MetroMall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.black12,
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
                'Your data is empty.',
                style: TextStyle(
                    color: Color.fromRGBO(233, 233, 232, 1),
                    fontWeight: FontWeight.w200,
                    fontFamily: 'prompt',
                    fontSize: 22),
              ),
            );
          } else if (snapShot.hasData) {
            MetroMallObject metroMallObject = snapShot.data;
            var _metromallList = metroMallObject.linelist;
            var _stationList = _metromallList[0].stationlist;
            //print(_stationList.length);
            return Container(
              padding: EdgeInsets.only(top: 5.0),
              height: 1000,
              child: CustomScrollView(
                physics: NeverScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 550.0, // image height
                      child: ListView.builder(
                        //physics: AlwaysScrollableScrollPhysics(),
                        itemExtent: 90.0, //image width
                        itemCount: _stationList.length,
                        // addAutomaticKeepAlives: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => Container(
                          //color: Colors.blue,
                          height: 150.0,
                          //margin: EdgeInsets.all(5.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(5.0),
                                  height: 60.0,
                                  //margin: EdgeInsets.all(5.0),
                                  child: ListTile(
                                    leading: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/icons/GoAround/img_icon_train_blue_gra.png'))),
                                    ),
                                    title: Text(_metromallList[0]
                                        .stationlist[index]
                                        .stationName),
                                    trailing: Container(
                                        height: 25,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blue[900],
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                          _metromallList[0]
                                              .stationlist[index]
                                              .stationCode,
                                          style: TextStyle(
                                            color: Colors.blue[900],
                                          ),
                                        ))),
                                    onTap: () {
                                      showCustomDialog(
                                          _metromallList[0]
                                              .stationlist[index]
                                              .stationCode,
                                          _metromallList[0]
                                              .stationlist[index]
                                              .stationName,
                                          _metromallList[0]
                                              .stationlist[index]
                                              .malllist[0]
                                              .mallIcon);
                                    },
                                    
                                  )),
                              Divider(
                                height: 20,
                                color: Colors.black38,
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

  void showCustomDialog(String stCode, String stName, String icons) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 500.0,
        width: 300.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 600,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 90.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'images/icons/GoAround/img_icon_station_popup.png'))),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                        height: 25,
                        width: 60,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blue[900], width: 2),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                          stCode,
                          style: TextStyle(
                            color: Colors.blue[900],
                          ),
                        ))),
                    SizedBox(height: 10.0),
                    Container(child: Text("$stName")),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 8.0),
                      child: Divider(
                        color: Colors.black38,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          height: 40.0,
                          child: Text("ร้านค้า"),
                        ),
                        Container(
                            color: Colors.black45,
                            height: 250.0,
                            width: 280.0,
                            child: GridView.count(
                              crossAxisCount: 4,
                              //childAspectRatio: 1.5,
                              children: <Widget>[
                                Center(
                                  child: _getIcons()
                                )
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              // These values are based on trial & error method
              // close button
              alignment: Alignment(1.05, -1.05),
              child: InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

  Widget _getIcons() {
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
            MetroMallObject metroMallObject = snapShot.data;
            var _metromallList = metroMallObject.linelist;
            var _mallList = _metromallList[0].stationlist;
            //print(_stationList.length);
            return Container(
              padding: EdgeInsets.only(top: 5.0),
              height: 500,width: 500,
              child: CustomScrollView(
                physics: NeverScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 90.0, // image height
                      child: ListView.builder(
                        //physics: AlwaysScrollableScrollPhysics(),
                        itemExtent: 60.0, //image width
                        itemCount: _mallList[0].malllist.length,
                        // addAutomaticKeepAlives: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => 
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(_mallList[0].malllist[index].mallIcon),
                        )
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
