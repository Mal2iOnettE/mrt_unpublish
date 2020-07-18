import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:promotion_mrt/HomePage/Object/NewsObject.dart';

class NewsPageDetail extends StatefulWidget {
  final String newsTitle;
  final int newsId;

  NewsPageDetail({Key key , this.newsTitle,this.newsId}) : super(key:key);

  @override
  NewsPageDetailState createState() => NewsPageDetailState();
}

class NewsPageDetailState extends State<NewsPageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("id:${widget.newsId} , ${widget.newsTitle}  "),
      ),
      body: _buildPromotionWidget() 
    );


  }

    Widget _buildPromotionWidget() {
    return FutureBuilder(
      future: _fetchPromotionList(),
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
          NewsPageObject newsPageObject = snapShot.data;
          var _newsList = newsPageObject.newslist;

          return Container(
            height: 600,
            child: CustomScrollView(
            //physics: NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 600.0, // image height
                    child: ListView.builder(
                      //physics: AlwaysScrollableScrollPhysics(),
                      itemExtent: 600.0, //image width
                      itemCount: newsPageObject.newslist.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => Container(
                        child: ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          //Cover
                          Column(
                            children: <Widget>[
                              Container(
                                height: 250.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(_newsList[index].newsCover)
                                  )
                                ),
                              )
                            ],
                          ),
                          //Title
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    _newsList[index].newsTitle,
                                    style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                          //Date
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding:
                                      EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    _newsList[index].newsDate,
                                    style: TextStyle(color: Colors.lime[900]),
                                  ))
                            ],
                          ),
                          //Divider
                          Container(
                              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                              child: Divider(color: Colors.black)),
                  
                          //Detail
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding:
                                      EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                                  child: Text("รายละเอียด",
                                      style:
                                          TextStyle(color: Colors.lime[900]))),
                              HtmlWidget(_newsList[index].newsDetail)
                            ],
                          )
                        ],
                      )),
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
      },
    );
  }

  Future<NewsPageObject> _fetchPromotionList() async {
    //print('_fetchPromotionList');
    try {
      Response response = await Dio().get(
        'http://bem-v2.podrealm.com/webservice/api/News/getNewsRecomment',
      );
      var branchListResult = NewsPageObject.fromJson(response.data);
      if (branchListResult.errCode == 0) {
        return branchListResult;
      } else {
        _showDialog(branchListResult.errMessage);
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