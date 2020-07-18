import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:promotion_mrt/InfomationMenu/imformationPage.dart';
import 'package:promotion_mrt/OtherMenu/OtherPage.dart';
import 'package:promotion_mrt/PromotionMenu/AllPromotionPage.dart';
import 'package:promotion_mrt/HomePage/HomePageAPI.dart';

class BottomNavyBar extends StatefulWidget {
  @override
  _BouttomBarState createState() => _BouttomBarState();
}

class _BouttomBarState extends State<BottomNavyBar> {
  int currentIndex;
  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Container(
      child: HomePage(),
    ),
    Container(
      child: AllPromotonPage(),
    ),
    Container(
      child: InfomationPage(),
    ),
    Container(
      child: OtherPage(),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      return new MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: Center(child: Text("BANGKOK MRT")),
              ),
              body: Center(
                child: _widgetOptions.elementAt(currentIndex),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.map),
                backgroundColor: Colors.red,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              bottomNavigationBar: BubbleBottomBar(
                hasNotch: true,
                //fabLocation: BubbleBottomBarFabLocation.center,
                opacity: .2,
                currentIndex: currentIndex,
                onTap: changePage,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0)), //border radius doesn't work when the notch is enabled.
                elevation: 20.0,
                items: <BubbleBottomBarItem>[
                  BubbleBottomBarItem(
                    title: Text("Main"),
                    backgroundColor: Colors.red,
                    icon: Icon(Icons.home, color: Colors.black54, size: 35),
                    activeIcon: Icon(
                      Icons.home,
                      color: Colors.red,
                    ),
                  ),
                  BubbleBottomBarItem(
                    title: Text("Promotion"),
                    backgroundColor: Colors.deepPurple,
                    icon: Icon(Icons.local_offer,
                        color: Colors.black54, size: 35),
                    activeIcon: Icon(
                      Icons.local_offer,
                      color: Colors.deepPurple,
                    ),
                  ),
                  BubbleBottomBarItem(
                    title: Text("Information"),
                    backgroundColor: Colors.indigo,
                    icon: Icon(
                      Icons.info,
                      color: Colors.black54,
                      size: 35,
                    ),
                    activeIcon: Icon(
                      Icons.info,
                      color: Colors.indigo,
                    ),
                  ),
                  BubbleBottomBarItem(
                    title: Text("Contact"),
                    backgroundColor: Colors.green,
                    icon:
                        Icon(Icons.more_horiz, color: Colors.black54, size: 35),
                    activeIcon: Icon(
                      Icons.more_horiz,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            );
          });
    });
  }
}
/*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("BANGKOK MRT")),
      ),
      body: Center(
        child: _widgetOptions.elementAt(currentIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.map),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BubbleBottomBar(
       
        hasNotch: true,
        //fabLocation: BubbleBottomBarFabLocation.center,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0)), //border radius doesn't work when the notch is enabled.
        elevation: 20.0,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            title: Text("Main"),
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.home, 
              color: Colors.black54, 
              size: 35),
            activeIcon: Icon(
              Icons.home,
              color: Colors.red,
            ),
          ),
          BubbleBottomBarItem(
            title: Text("Promotion"),
            backgroundColor: Colors.deepPurple,
            icon: Icon(
              Icons.local_offer, 
              color: Colors.black54, 
              size: 35),
            activeIcon: Icon(
              Icons.local_offer,
              color: Colors.deepPurple,
            ),
          ),
          
          BubbleBottomBarItem(
            title: Text("Information"),
            backgroundColor: Colors.indigo,
            icon: Icon(
              Icons.info,
              color: Colors.black54,
              size: 35,
            ),
            activeIcon: Icon(
              Icons.info,
              color: Colors.indigo,
            ),
          ),
          BubbleBottomBarItem(
            title: Text("Contact"),
            backgroundColor: Colors.green,
            icon: Icon(
              Icons.more_horiz, 
              color: Colors.black54, 
              size: 35),
            activeIcon: Icon(
              Icons.more_horiz,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}*/
