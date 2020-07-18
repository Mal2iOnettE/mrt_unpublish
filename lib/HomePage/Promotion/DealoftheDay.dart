import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:promotion_mrt/HomePage/Object/PromotionObject.dart';
import 'package:promotion_mrt/HomePage/Promotion/PromotionPage.dart';

class DealOfTheDay extends StatefulWidget {
  @override
  _DealOfTheDayState createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
 @override
  Widget build(BuildContext context) {
    return _buildMainPageWidget();
  }
  void _promotionpage(){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => PromotionPage()
    ));
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
            PromotionObject homePageObject = snapShot.data;
            var _promotionList = homePageObject.promotionMrtcaed;
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
                        itemCount: homePageObject.promotionMrtcaed.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          //color: Colors.blue,
                          height: 150.0,
                          //margin: EdgeInsets.all(5.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: 250.0,
                                    width: 250.0,
                                    //margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.black12,
                                            offset: new Offset(5.0, 5.0),
                                            blurRadius: 1.0
                                          )
                                        ],
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                _promotionList[index].promotionCover),
                                            fit: BoxFit.cover)
                                      ),
                                    child: InkWell(
                                      onTap: () => 
                                      //print('asfsdfasdf'),
                                      _promotionpage(),
                                     // child: Image.asset('images/icons/info/img_pin_transparent.png')
                                    ),
                                  ),
                                ],
                              ),
                              /*Container(
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
                              )*/
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

  Future<PromotionObject> _fetchMainPageList() async {
    // print('_fetchMainPageList');
    try {
      String homePageUrl =
          "http://bem-v2.podrealm.com/webservice/api/Promotion/getPromotion";
      Response response = await Dio().get(homePageUrl);
      var resultOfList = PromotionObject.fromJson(response.data);
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