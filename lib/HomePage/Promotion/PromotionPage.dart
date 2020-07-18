import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:promotion_mrt/HomePage/Object/PromotionObject.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PromotionPage extends StatefulWidget {
  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BANGKOK MRT"),
        ),
        body: _buildPromotionWidget());
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
          PromotionObject promotionPageObject = snapShot.data;
          var _promotionList = promotionPageObject.promotionMrtcaed;
          var promo_detail_html = _promotionList[0].promotionDetail;
          var promo_cover = _promotionList[0].promotionCover;
          var promo_date = _promotionList[0].promotionDate;
          var promo_title = _promotionList[0].promotionTitle;

          return SafeArea(
            child: Container(
                child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                //Cover
                Column(
                  children: <Widget>[Image.network(promo_cover)],
                ),
                //Title
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          promo_title,
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
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                        child: Text(
                          promo_date,
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
                   //HtmlWidget(promo_detail_html)
                   HtmlWidget(getHtml())
                  ],
                )
              ],
            )),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  getHtml(){
    String datahtml;
    return datahtml= """<form id="checkoutForm" method="POST" action="/charge">
  <input type="hidden" name="omiseToken">
  <input type="hidden" name="omiseSource">
  <button type="submit" id="checkoutButton">Checkout</button>
</form>

<script type="text/javascript" src="https://cdn.omise.co/omise.js">
</script>

<script>
  OmiseCard.configure({
    publicKey: "OMISE_PUBLIC_KEY"
  });

  var button = document.querySelector("#checkoutButton");
  var form = document.querySelector("#checkoutForm");

  button.addEventListener("click", (event) => {
    event.preventDefault();
    OmiseCard.open({
      amount: 12345,
      currency: "THB",
      defaultPaymentMethod: "credit_card",
      onCreateTokenSuccess: (nonce) => {
          if (nonce.startsWith("tokn_")) {
              form.omiseToken.value = nonce;
          } else {
              form.omiseSource.value = nonce;
          };
        form.submit();
      }
    });
  });
</script>""";
  }
 
 

  Future<PromotionObject> _fetchPromotionList() async {
    //print('_fetchPromotionList');
    try {
      Response response = await Dio().get(
        'http://bem-v2.podrealm.com/webservice/api/Promotion/getPromotion',
      );
      var branchListResult = PromotionObject.fromJson(response.data);
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
