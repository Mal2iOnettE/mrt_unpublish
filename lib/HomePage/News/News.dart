import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:promotion_mrt/HomePage/News/NewsPage.dart';
import 'package:promotion_mrt/HomePage/Object/MainPageObject.dart';

class NewsPage extends StatefulWidget {
  final String title;
  final int newsId;

  const NewsPage({Key key, this.title , this.newsId}) : super(key: key);
  
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
 @override
  Widget build(BuildContext context) {
    return _buildMainPageWidget();
  }

  _sendData(String newsTitle,int newsId){
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => 
      NewsPageDetail(newsTitle: newsTitle, newsId: newsId,))
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
            var _newsList = homePageObject.newslist;
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
                        itemExtent: 400, //image width
                        itemCount: homePageObject.newslist.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          height: 200.0,
                          margin: EdgeInsets.all(5.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: 250.0,
                                    //margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                _newsList[index].newsCover
                                                ),
                                            fit: BoxFit.contain)),
                                            child: InkWell(
                                              onTap: (){
                                                _sendData(_newsList[index].newsTitle,_newsList[index].newsId);
                                              },
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