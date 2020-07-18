import 'package:flutter/material.dart';
import 'package:promotion_mrt/BottomBar/tab_navigator.dart';
import 'package:promotion_mrt/HomePage/ExMenu/StationAndMetromall/MetroMall.dart';
import 'package:promotion_mrt/HomePage/ExMenu/StationAndMetromall/Stations.dart';

class StationAndMetromall extends StatefulWidget {
  @override
  _StationAndMetromallState createState() => _StationAndMetromallState();
}

class _StationAndMetromallState extends State<StationAndMetromall> {
  _onTap(int index) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return new MetroMall();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.directions_car),
                  text: "Station"
                  ),
                Tab(
                  icon: Icon(Icons.directions_transit),
                  text: "Metro Mall",
                  ),
              ],
            ),
           // title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [  
              Stations(),
              MetroMall(),
            ],
          ),
        ),
    );
  }

  //body: _body(),
  //bottomNavigationBar: _bottomNavigationBar(),
 
}
