
import 'package:flutter/material.dart';
import 'package:promotion_mrt/HomePage/HomePageAPI.dart';
import 'package:promotion_mrt/OtherMenu/OtherPage.dart';
import 'bttmBar.dart';
import 'color_detail.dart';
import 'color_list.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
  static const String vdo = '/vdo';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context, {int materialIndex: 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.vdo](context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.root: (context) => ColorsListPage(
            color: activeTabColor[tabItem],
            title: tabName[tabItem],
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex),
          ),
      TabNavigatorRoutes.vdo: (context) => OtherPage(
           /* color: activeTabColor[tabItem],*/
           /* title: tabName[tabItem],
            materialIndex: materialIndex,*/
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}