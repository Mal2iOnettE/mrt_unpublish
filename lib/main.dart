import 'package:flutter/material.dart';
import 'package:promotion_mrt/BottomBar/BottomBar.dart';
import 'package:promotion_mrt/BottomBar/bttombarTest.dart';
import 'package:promotion_mrt/DashboardScreen.dart';
import 'package:promotion_mrt/HomePage/ExMenu/StationAndMetromall/stationAndMetro.dart';
import 'package:promotion_mrt/HomePage/HomePageAPI.dart';
import 'package:promotion_mrt/HomePage/Promotion/PromotionPage.dart';
import 'package:promotion_mrt/InfomationMenu/subInformation/ticketPrice.dart';
import 'BottomBar/bttmBar.dart';
import 'BottomBar/app.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
      routes: <String,WidgetBuilder>{
        "/promotion": (BuildContext context) => new PromotionPage(),
      }
    );
  }
}