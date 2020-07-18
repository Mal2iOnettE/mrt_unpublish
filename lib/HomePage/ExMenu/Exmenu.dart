import 'package:flutter/material.dart';
import 'package:promotion_mrt/HomePage/ExMenu/StationAndMetromall/stationAndMetro.dart';

class ExMenu extends StatefulWidget {
  @override
  _ExMenuState createState() => _ExMenuState();
}

class _ExMenuState extends State<ExMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.0,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        primary: true,
        padding: const EdgeInsets.all(8),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 1.7,
        children: <Widget>[
          Container(
            height: 180.0,
            padding: const EdgeInsets.all(8),
            //color: Colors.teal[100],
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'images/img_bg_info/img_bg_info_metro.png'))),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StationAndMetromall(),
                        ),
                     
                      );
              },
            ),
          ),
          Container(
            height: 180.0,
            padding: const EdgeInsets.all(8),
            //child: const Text('Heed not the rabble'),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'images/img_bg_info/img_bg_info_lucky.png'))),
          ),
          Container(
            height: 180.0,
            padding: const EdgeInsets.all(8),
            //child: const Text('Sound of screams but the'),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('images/img_bg_info/img_bg_info_park.png'))),
          ),
          Container(
            height: 180.0,
            padding: const EdgeInsets.all(8),
            //child: const Text('Who scream'),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'images/img_bg_info/img_bg_info_mshop.png'))),
          ),
        ],
      ),
    );
  }
}
