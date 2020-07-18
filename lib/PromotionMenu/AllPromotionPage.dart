import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:promotion_mrt/HomePage/Object/PromotionObject.dart';
import 'package:promotion_mrt/HomePage/Promotion/PromotionPage.dart';

class AllPromotonPage extends StatefulWidget {
  @override
  _AllPromotonPageState createState() => _AllPromotonPageState();
}

class _AllPromotonPageState extends State<AllPromotonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BANGKOK MRT"),
        centerTitle: true,
      ),
      body: _buildMainPageWidget()
      );
  }

  void _promotionpage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PromotionPage()));
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
            return ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                      padding: EdgeInsets.only(top: 5.0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 5.0, color: Colors.black12))),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Metro Mall Promotions",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => AllPromotonPage()));
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "MRT Card Privileges",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          Container(
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
                                      //itemCount: 1,
                                      itemCount:homePageObject.promotionMrtcaed.length,
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
                                                      borderRadius:
                                                          BorderRadius.circular(12),
                                                      boxShadow: [
                                                        new BoxShadow(
                                                            color: Colors.black12,
                                                            offset: new Offset(
                                                                5.0, 5.0),
                                                            blurRadius: 1.0)
                                                      ],
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              _promotionList[index]
                                                                  .promotionCover),
                                                          fit: BoxFit.cover)),
                                                  child: InkWell(
                                                    onTap: () =>
                                                        _promotionpage()
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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
