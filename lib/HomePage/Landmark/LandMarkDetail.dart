import 'package:carousel_pro/carousel_pro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:promotion_mrt/HomePage/Object/LandMarkByIdObject.dart';


class LandMarkDetail extends StatefulWidget {
  final String title;
  final int landId;

  LandMarkDetail({Key key, this.title, this.landId}) : super(key: key);

  @override
  _LandMarkDetailState createState() => _LandMarkDetailState();
}

class _LandMarkDetailState extends State<LandMarkDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text("MRT Go Around"),
          title: Text("${widget.title}, ${widget.landId}"),
        ),
        body: _buildPromotionWidget());
  }

  /*checkdata(){
    if(imagesList != null){
      return imagesList;
    }
    else{
      return imageCover;
    }
  }*/

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
          LandMarkByIdObject landmarkByIdObject = snapShot.data;
          var _landmarkByIdList = landmarkByIdObject.landmark;
          var imagesList = _landmarkByIdList.imagelist;
          var imageCover = _landmarkByIdList.landmarkCover;
          //print("imageList: $imagesList");
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
                      itemCount: landmarkByIdObject.landmark.imagelist.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => Container(
                          child: ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          //Cover
                          Column(
                            children: <Widget>[
                             /* CarouselSlider.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, int pos) {
                                    //print("pos $pos");
                                    if (imagesList == null) {
                                      Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:NetworkImage(imageCover))
                                                ),
                                            child: Text('pos $pos'),
                                      );
                                    } else {
                                      Container(
                                        child: Carousel(
                                          images: [
                                            NetworkImage(imageCover),
                                            NetworkImage(imagesList[index].landmarkImage),
                                          ],
                                        ),
                                      );
                                    }
                                  })*/
                              Container(
                                height: 250.0,
                                child: Carousel(
                                  images: [
                                    NetworkImage(imageCover),
                                    NetworkImage(
                                        imagesList[index].landmarkImage
                                        )
                                  ],
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
                                    _landmarkByIdList.landmarkName,
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
                                    _landmarkByIdList.landmarkNear,
                                    style: TextStyle(color: Colors.lime[900]),
                                  ))
                            ],
                          ),
                          //Divider
                          Container(
                              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                              child: Divider(color: Colors.black)),

                          ///how to get there
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding:
                                      EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                                  child: Text("วิธีการเดินทาง",
                                      style:
                                          TextStyle(color: Colors.lime[900]))),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                    '${_landmarkByIdList.landmarkJourney}'),
                              )
                            ],
                          ),

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
                              HtmlWidget(_landmarkByIdList.landmarkDetail)
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

  Future<LandMarkByIdObject> _fetchPromotionList() async {
    //print('_fetchPromotionList');
    try {
      //print("landId: ${widget.landId}");
      Response response = await Dio().get(
        'http://bem-v2.podrealm.com/webservice/api/Landmark/getAroundId/${widget.landId}/1?_type=0',
      );
      // print(response);
      var branchListResult = LandMarkByIdObject.fromJson(response.data);
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
          content: new Text("เกิดอะไรขึ้นหว่าา?????? :0"),
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
