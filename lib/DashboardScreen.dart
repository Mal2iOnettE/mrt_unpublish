import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:promotion_mrt/HomePage/HomePageAPI.dart';
import 'package:promotion_mrt/HomePage/Promotion/PromotionPage.dart';
import 'package:promotion_mrt/InfomationMenu/imformationPage.dart';
import 'package:promotion_mrt/OtherMenu/OtherPage.dart';
import 'package:promotion_mrt/PromotionMenu/AllPromotionPage.dart';

/*void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  runApp(MyApp());
}*/

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _tabNavigator = GlobalKey<TabNavigatorState>();
  final _tab1 = GlobalKey<NavigatorState>();
  final _tab2 = GlobalKey<NavigatorState>();
  final _tab3 = GlobalKey<NavigatorState>();
  final _tab4 = GlobalKey<NavigatorState>();
  final _tab5 = GlobalKey<NavigatorState>();

  var _tabSelectedIndex = 0;
  var _tabPopStack = false;

  void _setIndex(index) {
    setState(() {
     _tabPopStack = _tabSelectedIndex == index;
      _tabSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
     onWillPop: () async => !await _tabNavigator.currentState.maybePop(), //bottom back button
      child: Scaffold(
        body: TabNavigator(
          key: _tabNavigator,
          tabs: <TabItem>[
            TabItem(_tab1, HomePage()),
            TabItem(_tab2, AllPromotonPage()),
            TabItem(_tab3, PageWithButton(title: 'Map')),
            TabItem(_tab4, InfomationPage()),
            TabItem(_tab5, OtherPage()),
          ],
          selectedIndex: _tabSelectedIndex,
          popStack: _tabPopStack,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tabSelectedIndex,
          backgroundColor: Colors.blue,
          onTap: _setIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.audiotrack),
                title: Text('Home'),
                backgroundColor: Colors.blue,),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_offer),
                title: Text('Promotion'),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text('Map'),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.info_outline),
                title: Text('Infomation'),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                title: Text('Other'),
                backgroundColor: Colors.blue),
          ],
        ),
      ),
    );
  }
}

class PageWithButton extends StatelessWidget {
  final String title;
  const PageWithButton({
    Key key,
    @required this.title,
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
      body: Container(
        child: HomePage() ,
              ),
          );
          }
        }

class TabItem {
  final GlobalKey<NavigatorState> key;
  final Widget tab;
  const TabItem(this.key, this.tab);
}

class TabNavigator extends StatefulWidget {
  final List<TabItem> tabs;
  final int selectedIndex;
  final bool popStack;

  TabNavigator({
    Key key,
    @required this.tabs,
    @required this.selectedIndex,
    this.popStack = true,
  }) : super(key: key);

  @override
  TabNavigatorState createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {
  ///
  /// Try to pop widget, return true if popped
  ///
  Future<bool> maybePop() {
    return widget.tabs[widget.selectedIndex].key.currentState.maybePop();
  }
  _popStackIfRequired(BuildContext context) async {
    if (widget.popStack) {
      widget.tabs[widget.selectedIndex].key.currentState
          .popUntil((route) => route.isFirst);
    }
  }
  @override
  Widget build(BuildContext context) {
    print('selectedIndex=${widget.selectedIndex}, popStack=${widget.popStack}');
    _popStackIfRequired(context);
    return Stack(
      children: List.generate(widget.tabs.length, _buildTab),
    );
  }

  Widget _buildTab(int index) {
    return Offstage(
      offstage: widget.selectedIndex != index,
      child: Opacity(
        opacity: widget.selectedIndex == index ? 1.0 : 0.0,
        child: Navigator(
          key: widget.tabs[index].key,
          onGenerateRoute: (settings) => 
          MaterialPageRoute(
            settings: settings,
            builder: (_) => widget.tabs[index].tab,
          ),
          
        ),
      ),
    );
  }
}
