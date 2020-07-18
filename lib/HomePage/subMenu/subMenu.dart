import 'package:flutter/material.dart';

class SubMenu extends StatefulWidget {
  @override
  SubMenuState createState() => SubMenuState();
}

class SubMenuState extends State<SubMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ///ค้นหาเส้นทาง
        Column(
          children: <Widget>[
            Container(
                height: 50.0,
                child: Image.asset('images/img_button/img_button_route.png')),
            Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(
                      'ค้นหาเส้นทาง',
                      style: TextStyle(fontSize: 12.0),
                    )),
              ],
            ),
            Column(
              children: <Widget>[Text("")],
            )
          ],
        ),

        ///ข้อมูลสถานี
        Column(
          children: <Widget>[
            Container(
                height: 50.0,
                child: Image.asset(
                    'images/img_button/img_button_info_station.png')),
            Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 3.0),
                    child:
                        Text('ข้อมูลสถานี', style: TextStyle(fontSize: 12.0))),
              ],
            ),
            Column(
              children: <Widget>[Text("")],
            )
          ],
        ),

        ///MRT Club
        Column(
          children: <Widget>[
            Container(
                height: 50.0,
                child: Image.asset('images/img_button/img_button_mrtclub.png')),
            Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text('MRT Club', style: TextStyle(fontSize: 12.0))),
              ],
            ),
            Column(
              children: <Widget>[Text("")],
            )
          ],
        ),

        ///ตั๋วโดยสาร
        Column(
          children: <Widget>[
            Container(
                height: 50.0,
                child: Image.asset('images/img_button/img_button_ticket.png')),
            Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 3.0),
                    child:
                        Text('ตั๋วโดยสาร', style: TextStyle(fontSize: 12.0))),
              ],
            ),
            Column(
              children: <Widget>[Text("")],
            )
          ],
        ),

        ///ขบวนแรก/สุดท้าย
        Column(
          children: <Widget>[
            Container(
                height: 50.0,
                child: Image.asset(
                    'images/img_button/img_button_first_last_train.png')),
            Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 3.0),
                        child:
                            Text('ขบวนแรก/', style: TextStyle(fontSize: 12.0))),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text('สุดท้าย', style: TextStyle(fontSize: 12.0))
              ],
            )
          ],
        ),
      ],
    );
  }
}
